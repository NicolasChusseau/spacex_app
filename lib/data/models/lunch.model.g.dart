// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunch.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lunch _$LunchFromJson(Map<String, dynamic> json) => Lunch(
  id: json['id'] as String,
  name: json['name'] as String,
  details: json['details'] as String?,
  rocket: json['rocket'] as String,
  dateUtc: json['date_utc'] == null
      ? null
      : DateTime.parse(json['date_utc'] as String),
  success: json['success'] as bool?,
  links: json['links'] == null
      ? null
      : LunchLinks.fromJson(json['links'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LunchToJson(Lunch instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'details': instance.details,
  'rocket': instance.rocket,
  'date_utc': instance.dateUtc?.toIso8601String(),
  'success': instance.success,
  'links': instance.links,
};
