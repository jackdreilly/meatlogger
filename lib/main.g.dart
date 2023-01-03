// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Person _$$_PersonFromJson(Map<String, dynamic> json) => _$_Person(
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      updateTime: DateTime.parse(json['updateTime'] as String),
    );

Map<String, dynamic> _$$_PersonToJson(_$_Person instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'updateTime': instance.updateTime.toIso8601String(),
    };

_$_Lift _$$_LiftFromJson(Map<String, dynamic> json) => _$_Lift(
      bar: json['bar'] as bool?,
      lift: json['lift'] as String,
      count: json['count'] as int?,
    );

Map<String, dynamic> _$$_LiftToJson(_$_Lift instance) => <String, dynamic>{
      'bar': instance.bar,
      'lift': instance.lift,
      'count': instance.count,
    };

_$_Log _$$_LogFromJson(Map<String, dynamic> json) => _$_Log(
      weight: json['weight'] as num,
      reps: json['reps'] as int,
      date: DateTime.parse(json['date'] as String),
      lift: json['lift'] as String,
    );

Map<String, dynamic> _$$_LogToJson(_$_Log instance) => <String, dynamic>{
      'weight': instance.weight,
      'reps': instance.reps,
      'date': instance.date.toIso8601String(),
      'lift': instance.lift,
    };
