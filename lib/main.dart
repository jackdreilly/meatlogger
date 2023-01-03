import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meatlogger/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
part 'main.freezed.dart';
part 'main.g.dart';

@freezed
class Person with _$Person {
  const factory Person({
    String? displayName,
    String? email,
    required DateTime updateTime,
  }) = _Person;

  factory Person.fromJson(Data json) => _$PersonFromJson(json);
}

final usersCollection = FirebaseFirestore.instance.collection('users').withConverter(
    fromFirestore: (a, _) => Person.fromJson(a.data() ?? {}), toFirestore: (a, _) => a.toJson());
final liftsCollection = FirebaseFirestore.instance.collection('lifts').withConverter(
    fromFirestore: (a, _) => Lift.fromJson(a.data() ?? {}), toFirestore: (a, _) => a.toJson());

extension on String {
  CollectionReference<Log> get uidLogs => uidPerson.collection('logs').withConverter(
      fromFirestore: (a, _) => Log.fromJson(a.data() ?? {}),
      toFirestore: (value, options) => value.toJson());
  DocumentReference<Person> get uidPerson => usersCollection.doc(this);
}

extension on User {
  CollectionReference<Log> get logs => uid.uidLogs;
  DocumentReference<Person> get ref => uid.uidPerson;
  Person get toPerson => Person(displayName: displayName, email: email, updateTime: DateTime.now());
}

@freezed
class Lift with _$Lift {
  const factory Lift({bool? bar, required String lift, int? count}) = _Lift;

  factory Lift.fromJson(Data json) => _$LiftFromJson(json);
}

@freezed
class Log with _$Log {
  const factory Log({
    required num weight,
    required int reps,
    required DateTime date,
    required String lift,
  }) = _Log;

  factory Log.fromJson(Data json) => _$LogFromJson(json);
}

extension on Lift {
  bool get hasBar => bar ?? false;
}

typedef Data = Map<String, Object?>;
typedef Logs = List<QueryDocumentSnapshot<Log>>;

typedef Lifts = List<Lift>;
typedef People = List<QueryDocumentSnapshot<Person>>;

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      print(e);
    }
  }
  final users = StreamProvider<People>(
      initialData: const [], create: (_) => usersCollection.snapshots().map((event) => event.docs));
  final userProvider = StreamProvider.value(
      value: FirebaseAuth.instance.userChanges(), initialData: FirebaseAuth.instance.currentUser);
  final logsProvider = StreamProvider<Logs>(
      initialData: const [],
      create: (context) => FirebaseAuth.instance.userChanges().switchMap((value) =>
          value?.logs.orderBy('date', descending: true).snapshots().map((event) => event.docs) ??
          const Stream.empty()));
  final liftsProvider = StreamProvider<Lifts>(
      initialData: const [],
      create: (context) => FirebaseAuth.instance.userChanges().switchMap((value) => liftsCollection
          .orderBy('count', descending: true)
          .snapshots()
          .map((event) => event.docs.map((e) => e.data()).toList())));
  runApp(MultiProvider(
      providers: [
        userProvider,
        logsProvider,
        users,
        liftsProvider,
      ],
      child: MaterialApp(
        home: const Home(),
        theme: ThemeData(useMaterial3: true),
      )));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) => context.watch<User?>() == null
      ? SignInScreen(
          providerConfigs: const [
            GoogleProviderConfiguration(
                clientId:
                    "330246328163-f3dga03n2kc9skcn2fg9hcog2pq41bcv.apps.googleusercontent.com")
          ],
          actions: [
            AuthStateChangeAction<SignedIn>((context, state) {
              final user = state.user;
              if (user == null) {
                return;
              }
              user.ref.set(user.toPerson);
            })
          ],
        )
      : const Application();
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user == null) {
      return const Text("failed");
    }
    return MyScaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(200.0, 80.0)),
                  ),
                  onPressed: () => context.goTo((_) => const NewLogPage()),
                  child: const Text(
                    "New Log",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  )),
            ),
          ),
          const SingleChildScrollView(child: HistoryWidget()),
        ],
      ),
    ));
  }
}

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Profile"),
          onTap: () {
            context.navigator.pop();
            context.goTo((_) => const MyScaffold(body: ProfileScreen()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.people),
          title: const Text("Browse"),
          onTap: () {
            context.navigator.pop();
            context.goTo((_) => const PeopleWidget());
          },
        ),
      ],
    ));
  }
}

AppBar appBar(BuildContext context) => AppBar(
    title: InkWell(
        onTap: () => context.navigator.popUntil((route) => route.isFirst),
        child: const Text("Meatlogger")));
Widget get drawer => const MyDrawer();

class MyScaffold extends StatelessWidget {
  final Widget body;
  const MyScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(context), drawer: drawer, body: body);
  }
}

extension on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
  goTo(WidgetBuilder builder) {
    return navigator.push(MaterialPageRoute(builder: builder));
  }

  People get people => watch();
  Logs get logs => watch();
  Lifts get lifts => watch();
  User? get userSnap => read();
  snack(String message, {Function(BuildContext context)? undo}) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
      action: undo == null ? null : SnackBarAction(label: "Undo", onPressed: () => undo(this)),
    ));
  }
}

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
        body: ListView(
            children: context.people
                .map((e) => ListTile(
                      title: Text(e.data().displayName ?? "anon"),
                      onTap: () => context.goTo((context) => BrowsePersonPage(e)),
                    ))
                .toList()));
  }
}

class BrowsePersonPage extends StatelessWidget {
  final QueryDocumentSnapshot<Person> person;
  const BrowsePersonPage(this.person, {super.key});

  @override
  Widget build(BuildContext context) => MyScaffold(
          body: ListView(
        children: [Text(person.data().displayName ?? "Anon"), HistoryWidget(person: person)],
      ));
}

class NewLogPage extends StatefulWidget {
  const NewLogPage({super.key});

  @override
  State<NewLogPage> createState() => _NewLogPageState();
}

class _NewLogPageState extends State<NewLogPage> {
  final _formKey = GlobalKey<FormState>();
  Lift? _lift;
  final Map<num, int> _weights = {};
  var seal = false;

  final weightController = TextEditingController();
  TextEditingController? repsController;
  @override
  Widget build(BuildContext context) {
    final lifts = context.lifts;
    return MyScaffold(
        body: Form(
            key: _formKey,
            child: ListView(
              children: [
                Card(
                  child: Wrap(children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Autocomplete<Lift>(
                          optionsBuilder: (textEditingValue) => lifts.where((e) =>
                              e.lift.toLowerCase().contains(textEditingValue.text.toLowerCase())),
                          displayStringForOption: (lift) => lift.lift,
                          onSelected: (option) => setState(() => _lift = option),
                          fieldViewBuilder:
                              (context, textEditingController, focusNode, onFieldSubmitted) =>
                                  TextFormField(
                            decoration: const InputDecoration(label: Text("Lift")),
                            controller: textEditingController,
                            focusNode: focusNode,
                            onFieldSubmitted: (String value) {
                              focusNode.unfocus();
                              textEditingController.text = "";
                              for (final lift in lifts) {
                                if (lift.lift.toLowerCase() == value.toLowerCase()) {
                                  setState(() {
                                    _lift = lift;
                                  });
                                  return;
                                }
                              }
                              setState(() {
                                final lift = Lift(lift: value.toLowerCase());
                                liftsCollection.doc(value.toLowerCase()).set(lift);
                                _lift = lift;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          label: const Text(
                            "Has Bar",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: _lift?.hasBar ?? false,
                          onSelected: _lift == null
                              ? null
                              : (value) => setState(() {
                                    final lift = _lift;
                                    if (lift == null) {
                                      return;
                                    }
                                    _lift = lift.copyWith(bar: value);
                                    liftsCollection.doc(_lift?.lift).set(_lift!);
                                  })),
                    ),
                    ...lifts.take(20).map((e) => Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: ChoiceChip(
                            label: Text(e.lift),
                            selected: e.lift == _lift?.lift,
                            onSelected: (value) => setState(() {
                              if (value) {
                                _lift = e;
                              }
                            }),
                          ),
                        ))
                  ]),
                ),
                Card(
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          Card(
                              child: Container(
                            padding: const EdgeInsets.only(left: 8),
                            width: 60,
                            child: TextField(
                                decoration: const InputDecoration(label: Text("Weight")),
                                onSubmitted: solveWeight,
                                controller: weightController,
                                keyboardType: TextInputType.number),
                          )),
                          ...[45, 25, 10, 5, 2.5].map((e) => Card(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed:
                                            ((_weights[e] ?? 0) > 0) ? () => inc(e, -1) : null,
                                        icon: const Icon(Icons.remove_circle)),
                                    ElevatedButton(
                                        onPressed: () => inc(e, 1), child: Text(e.toString()))
                                  ],
                                ),
                              ))
                        ],
                      ),
                      Card(
                        child: SizedBox(
                          height: 140,
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  color: Colors.grey,
                                  height: 10,
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: RackWidget(
                                  weights: _weights,
                                  direction: false,
                                  callback: (i) => inc(i, -1),
                                  widthFactor: _lift?.hasBar ?? false ? 0.45 : .95,
                                ),
                              ),
                              if (_lift?.hasBar ?? false)
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: RackWidget(
                                    weights: _weights,
                                    direction: true,
                                    callback: (i) => inc(i, -1),
                                    widthFactor: _lift?.hasBar ?? false ? 0.45 : .95,
                                  ),
                                )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(children: [
                      Card(
                          child: Container(
                        padding: const EdgeInsets.only(left: 8),
                        width: 60,
                        child: TextField(
                            decoration: const InputDecoration(label: Text("Reps")),
                            onSubmitted: (value) {
                              if (int.tryParse(value) == null) {
                                context.snack("type number");
                                return;
                              }
                              submit(int.parse(value));
                            },
                            controller: repsController,
                            keyboardType: TextInputType.number),
                      )),
                      ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 15, 20].map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () => submit(e), child: Text(e.toString())),
                          ))
                    ]),
                  ),
                ),
                const Card(child: HistoryWidget(today: true)),
              ],
            )));
  }

  num get weight {
    var weights = _weights.entries.map((e) => e.key * e.value).sum;
    if (_lift?.hasBar ?? false) {
      weights *= 2;
      weights += 45;
    }
    return weights;
  }

  void solveWeight(String value) {
    var maybeWeight = num.tryParse(value);
    if (maybeWeight == null) {
      setState(_weights.clear);
      return;
    }
    var weightValue = maybeWeight;
    if (_lift?.hasBar ?? false) {
      weightValue -= 45;
      weightValue /= 2;
    }
    final newWeights = <num, int>{};
    if (weightValue % 5 == 2.5) {
      newWeights[2.5] = 1;
      weightValue -= 2.5;
    }
    for (final plate in <num>[45, 25, 10, 5, 2.5]) {
      while (weightValue >= plate) {
        newWeights[plate] = newWeights.putIfAbsent(plate, () => 0) + 1;
        weightValue -= plate;
      }
    }
    _weights.clear();
    setState(() => _weights.addAll(newWeights));
  }

  inc(num e, int i) => setState(() => _weights[e] = ((_weights[e] ?? 0) + i).max(0).toInt());

  @override
  void setState(VoidCallback fn) {
    super.setState((() {
      fn();
      weightController.text = weight.toString();
    }));
  }

  submit(int e) {
    final user = context.userSnap;
    if (user == null) {
      context.snack("Not logged in");
      return;
    }
    if (_lift == null) {
      context.snack("Select lift");
      return;
    }
    if (_weights.isEmpty && !seal) {
      seal = true;
      context.snack("No weights set! click again to confirm");
      return;
    }
    final doc =
        user.logs.add(Log(weight: weight, reps: e, date: DateTime.now(), lift: _lift?.lift ?? ""));
    context.snack("Added $e ${_lift?.lift ?? ''} reps @ $weight lbs", undo: (context) {
      doc.then((value) => value.delete());
      context.snack("Undone");
    });
  }
}

class RackWidget extends StatelessWidget {
  final Map<num, int> weights;
  final Function(num weight) callback;
  final bool direction;
  final num widthFactor;
  const RackWidget({
    super.key,
    required this.weights,
    required this.callback,
    required this.direction,
    required this.widthFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * widthFactor,
        child: Row(
            mainAxisAlignment: direction ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: weights.entries
                .sorted((e) => (direction ? 1 : -1) * e.key)
                .expand((e) => Iterable.generate(
                    e.value,
                    (_) => Flexible(
                          child: Container(
                            height: e.key * 2 + 30,
                            constraints:
                                BoxConstraints(maxWidth: (e.key * 3).min(100).max(50).toDouble()),
                            child: Card(
                                color: Colors.black,
                                child: InkWell(
                                  onTap: () => callback(e.key),
                                  child: Center(
                                    child: Text(
                                      e.key.toString(),
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )),
                          ),
                        )))
                .toList()),
      ),
    );
  }
}

extension<T> on Iterable<T> {
  Set<T> get distinct => toSet();
  Map<K, List<T>> groupBy<K>(K Function(T value) grouper) {
    final result = <K, List<T>>{};
    for (final v in this) {
      result.putIfAbsent(grouper(v), () => []).add(v);
    }
    return result;
  }

  List<T> sorted(Comparable Function(T value) key, {bool ascending = true}) {
    final list = toList();
    list.sort((a, b) => key(a).compareTo(key(b)) * (ascending ? 1 : -1));
    return list;
  }
}

extension<T extends num> on Iterable<T> {
  num get sum => fold(0, (previousValue, element) => previousValue + element);
}

extension on CollectionReference {
  CollectionReference<Log> get logged => withConverter(
      fromFirestore: (a, _) => Log.fromJson(a.data() ?? {}),
      toFirestore: (value, options) => value.toJson());
}

extension on QueryDocumentSnapshot<Person> {
  Stream<List<QueryDocumentSnapshot<Log>>> get logs =>
      reference.collection('logs').logged.snapshots().map((event) => event.docs);
}

class HistoryWidget extends StatefulWidget {
  final bool today;
  final QueryDocumentSnapshot<Person>? person;
  const HistoryWidget({
    super.key,
    this.today = false,
    this.person,
  });

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  String? liftFilter;
  int? repsFilter;
  int sortColumn = 0;
  bool sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<QueryDocumentSnapshot<Log>>>(
        stream: widget.person?.logs ?? Stream.value(context.logs),
        initialData: const [],
        builder: (context, snapshot) {
          final filteredLogs = snapshot.data
                  ?.sorted(
                      (a) => <Comparable>[
                            a.data().date,
                            a.data().lift,
                            a.data().weight,
                            a.data().reps
                          ][sortColumn],
                      ascending: sortAscending)
                  .where((element) => Jiffy(element.data().date)
                      .isAfter(widget.today ? DateTime.now().beginningOfDay : DateTime(1970)))
                  .where((element) {
                final filter = liftFilter;
                if (filter == null) {
                  return true;
                }
                return element.data().lift == filter;
              }).where((element) {
                final filter = repsFilter;
                if (filter == null) {
                  return true;
                }
                return element.data().reps == filter;
              }).toList() ??
              [];
          return DataTable(
            sortAscending: sortAscending,
            sortColumnIndex: sortColumn,
            columnSpacing: 15,
            columns: [
              DataColumn(label: const Icon(Icons.calendar_month), onSort: onSort),
              DataColumn(
                  label: (liftFilter != null)
                      ? IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () => setState(() {
                                liftFilter = null;
                              }))
                      : const Icon(Icons.fitness_center_rounded),
                  onSort: onSort),
              DataColumn(
                  label: IconButton(
                      icon: const Icon(Icons.line_axis),
                      onPressed: () => showDialog(
                          context: context,
                          builder: (context) => Dialog(
                              child: SfCartesianChart(
                                  legend: Legend(isVisible: true),
                                  enableAxisAnimation: false,
                                  primaryXAxis: DateTimeAxis(),
                                  zoomPanBehavior: ZoomPanBehavior(
                                    enableSelectionZooming: true,
                                    enablePanning: true,
                                    enableDoubleTapZooming: true,
                                    enableMouseWheelZooming: true,
                                    enablePinching: true,
                                  ),
                                  series: filteredLogs
                                      .groupBy((x) => x.data().lift)
                                      .entries
                                      .map((e) => LineSeries<QueryDocumentSnapshot<Log>, DateTime>(
                                          legendItemText: e.key,
                                          animationDuration: 0,
                                          dataLabelMapper: (datum, index) =>
                                              datum.data().reps.toString(),
                                          enableTooltip: true,
                                          dataLabelSettings:
                                              const DataLabelSettings(isVisible: true),
                                          name: e.key,
                                          markerSettings: const MarkerSettings(isVisible: true),
                                          dataSource: e.value,
                                          xValueMapper: (QueryDocumentSnapshot<Log> log, _) =>
                                              log.data().date,
                                          yValueMapper: (QueryDocumentSnapshot<Log> log, _) =>
                                              log.data().weight))
                                      .toList())))),
                  onSort: onSort,
                  numeric: true),
              DataColumn(
                  label: (repsFilter != null)
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              icon: const Icon(Icons.filter_list),
                              onPressed: () => setState(() {
                                    repsFilter = null;
                                  })),
                        )
                      : const Text("Reps"),
                  onSort: onSort,
                  numeric: true),
              const DataColumn(label: Text("Del")),
            ],
            rows: filteredLogs
                .map((e) => DataRow(cells: [
                      DataCell(Text(Jiffy(e.data().date).fromNow())),
                      DataCell(Text(e.data().lift),
                          onTap: () => setState(
                              () => liftFilter = liftFilter == null ? e.data().lift : null)),
                      DataCell(Text(e.data().weight.toString())),
                      DataCell(Text(e.data().reps.toString()),
                          onTap: () => setState(
                              () => repsFilter = repsFilter == null ? e.data().reps : null)),
                      DataCell(const Icon(Icons.delete), onTap: () {
                        e.reference.delete();
                        context.snack("Deleted", undo: (context) {
                          e.reference.set(e.data());
                          context.snack("Restored");
                        });
                      })
                    ]))
                .toList(),
          );
        });
  }

  void onSort(int columnIndex, bool ascending) {
    setState(() {
      sortColumn = columnIndex;
      sortAscending = ascending;
    });
  }
}

extension on DateTime {
  DateTime get beginningOfDay => DateTime(year, month, day);
}

extension on num {
  num min(num x) => this < x ? this : x;
  num max(num x) => this > x ? this : x;
}
