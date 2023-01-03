// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Person _$PersonFromJson(Map<String, dynamic> json) {
  return _Person.fromJson(json);
}

/// @nodoc
mixin _$Person {
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  DateTime get updateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonCopyWith<Person> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonCopyWith<$Res> {
  factory $PersonCopyWith(Person value, $Res Function(Person) then) =
      _$PersonCopyWithImpl<$Res, Person>;
  @useResult
  $Res call({String? displayName, String? email, DateTime updateTime});
}

/// @nodoc
class _$PersonCopyWithImpl<$Res, $Val extends Person>
    implements $PersonCopyWith<$Res> {
  _$PersonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? updateTime = null,
  }) {
    return _then(_value.copyWith(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PersonCopyWith<$Res> implements $PersonCopyWith<$Res> {
  factory _$$_PersonCopyWith(_$_Person value, $Res Function(_$_Person) then) =
      __$$_PersonCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? displayName, String? email, DateTime updateTime});
}

/// @nodoc
class __$$_PersonCopyWithImpl<$Res>
    extends _$PersonCopyWithImpl<$Res, _$_Person>
    implements _$$_PersonCopyWith<$Res> {
  __$$_PersonCopyWithImpl(_$_Person _value, $Res Function(_$_Person) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = freezed,
    Object? email = freezed,
    Object? updateTime = null,
  }) {
    return _then(_$_Person(
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: null == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Person with DiagnosticableTreeMixin implements _Person {
  const _$_Person({this.displayName, this.email, required this.updateTime});

  factory _$_Person.fromJson(Map<String, dynamic> json) =>
      _$$_PersonFromJson(json);

  @override
  final String? displayName;
  @override
  final String? email;
  @override
  final DateTime updateTime;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Person(displayName: $displayName, email: $email, updateTime: $updateTime)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Person'))
      ..add(DiagnosticsProperty('displayName', displayName))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('updateTime', updateTime));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Person &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, displayName, email, updateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PersonCopyWith<_$_Person> get copyWith =>
      __$$_PersonCopyWithImpl<_$_Person>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PersonToJson(
      this,
    );
  }
}

abstract class _Person implements Person {
  const factory _Person(
      {final String? displayName,
      final String? email,
      required final DateTime updateTime}) = _$_Person;

  factory _Person.fromJson(Map<String, dynamic> json) = _$_Person.fromJson;

  @override
  String? get displayName;
  @override
  String? get email;
  @override
  DateTime get updateTime;
  @override
  @JsonKey(ignore: true)
  _$$_PersonCopyWith<_$_Person> get copyWith =>
      throw _privateConstructorUsedError;
}

Lift _$LiftFromJson(Map<String, dynamic> json) {
  return _Lift.fromJson(json);
}

/// @nodoc
mixin _$Lift {
  bool? get bar => throw _privateConstructorUsedError;
  String get lift => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LiftCopyWith<Lift> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LiftCopyWith<$Res> {
  factory $LiftCopyWith(Lift value, $Res Function(Lift) then) =
      _$LiftCopyWithImpl<$Res, Lift>;
  @useResult
  $Res call({bool? bar, String lift, int? count});
}

/// @nodoc
class _$LiftCopyWithImpl<$Res, $Val extends Lift>
    implements $LiftCopyWith<$Res> {
  _$LiftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bar = freezed,
    Object? lift = null,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      bar: freezed == bar
          ? _value.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as bool?,
      lift: null == lift
          ? _value.lift
          : lift // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LiftCopyWith<$Res> implements $LiftCopyWith<$Res> {
  factory _$$_LiftCopyWith(_$_Lift value, $Res Function(_$_Lift) then) =
      __$$_LiftCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? bar, String lift, int? count});
}

/// @nodoc
class __$$_LiftCopyWithImpl<$Res> extends _$LiftCopyWithImpl<$Res, _$_Lift>
    implements _$$_LiftCopyWith<$Res> {
  __$$_LiftCopyWithImpl(_$_Lift _value, $Res Function(_$_Lift) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? bar = freezed,
    Object? lift = null,
    Object? count = freezed,
  }) {
    return _then(_$_Lift(
      bar: freezed == bar
          ? _value.bar
          : bar // ignore: cast_nullable_to_non_nullable
              as bool?,
      lift: null == lift
          ? _value.lift
          : lift // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Lift with DiagnosticableTreeMixin implements _Lift {
  const _$_Lift({this.bar, required this.lift, this.count});

  factory _$_Lift.fromJson(Map<String, dynamic> json) => _$$_LiftFromJson(json);

  @override
  final bool? bar;
  @override
  final String lift;
  @override
  final int? count;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lift(bar: $bar, lift: $lift, count: $count)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Lift'))
      ..add(DiagnosticsProperty('bar', bar))
      ..add(DiagnosticsProperty('lift', lift))
      ..add(DiagnosticsProperty('count', count));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Lift &&
            (identical(other.bar, bar) || other.bar == bar) &&
            (identical(other.lift, lift) || other.lift == lift) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, bar, lift, count);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LiftCopyWith<_$_Lift> get copyWith =>
      __$$_LiftCopyWithImpl<_$_Lift>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LiftToJson(
      this,
    );
  }
}

abstract class _Lift implements Lift {
  const factory _Lift(
      {final bool? bar,
      required final String lift,
      final int? count}) = _$_Lift;

  factory _Lift.fromJson(Map<String, dynamic> json) = _$_Lift.fromJson;

  @override
  bool? get bar;
  @override
  String get lift;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$_LiftCopyWith<_$_Lift> get copyWith => throw _privateConstructorUsedError;
}

Log _$LogFromJson(Map<String, dynamic> json) {
  return _Log.fromJson(json);
}

/// @nodoc
mixin _$Log {
  num get weight => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get lift => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogCopyWith<Log> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogCopyWith<$Res> {
  factory $LogCopyWith(Log value, $Res Function(Log) then) =
      _$LogCopyWithImpl<$Res, Log>;
  @useResult
  $Res call({num weight, int reps, DateTime date, String lift});
}

/// @nodoc
class _$LogCopyWithImpl<$Res, $Val extends Log> implements $LogCopyWith<$Res> {
  _$LogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? reps = null,
    Object? date = null,
    Object? lift = null,
  }) {
    return _then(_value.copyWith(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as num,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lift: null == lift
          ? _value.lift
          : lift // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LogCopyWith<$Res> implements $LogCopyWith<$Res> {
  factory _$$_LogCopyWith(_$_Log value, $Res Function(_$_Log) then) =
      __$$_LogCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({num weight, int reps, DateTime date, String lift});
}

/// @nodoc
class __$$_LogCopyWithImpl<$Res> extends _$LogCopyWithImpl<$Res, _$_Log>
    implements _$$_LogCopyWith<$Res> {
  __$$_LogCopyWithImpl(_$_Log _value, $Res Function(_$_Log) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weight = null,
    Object? reps = null,
    Object? date = null,
    Object? lift = null,
  }) {
    return _then(_$_Log(
      weight: null == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as num,
      reps: null == reps
          ? _value.reps
          : reps // ignore: cast_nullable_to_non_nullable
              as int,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lift: null == lift
          ? _value.lift
          : lift // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Log with DiagnosticableTreeMixin implements _Log {
  const _$_Log(
      {required this.weight,
      required this.reps,
      required this.date,
      required this.lift});

  factory _$_Log.fromJson(Map<String, dynamic> json) => _$$_LogFromJson(json);

  @override
  final num weight;
  @override
  final int reps;
  @override
  final DateTime date;
  @override
  final String lift;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Log(weight: $weight, reps: $reps, date: $date, lift: $lift)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Log'))
      ..add(DiagnosticsProperty('weight', weight))
      ..add(DiagnosticsProperty('reps', reps))
      ..add(DiagnosticsProperty('date', date))
      ..add(DiagnosticsProperty('lift', lift));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Log &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.lift, lift) || other.lift == lift));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, weight, reps, date, lift);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LogCopyWith<_$_Log> get copyWith =>
      __$$_LogCopyWithImpl<_$_Log>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LogToJson(
      this,
    );
  }
}

abstract class _Log implements Log {
  const factory _Log(
      {required final num weight,
      required final int reps,
      required final DateTime date,
      required final String lift}) = _$_Log;

  factory _Log.fromJson(Map<String, dynamic> json) = _$_Log.fromJson;

  @override
  num get weight;
  @override
  int get reps;
  @override
  DateTime get date;
  @override
  String get lift;
  @override
  @JsonKey(ignore: true)
  _$$_LogCopyWith<_$_Log> get copyWith => throw _privateConstructorUsedError;
}
