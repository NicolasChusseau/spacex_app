// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rocket.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rocket _$RocketFromJson(Map<String, dynamic> json) => Rocket(
  id: json['id'] as String,
  name: json['name'] as String,
  type: json['type'] as String?,
  description: json['description'] as String?,
  wikipedia: json['wikipedia'] as String?,
  height: _heightFromJson(json['height'] as Map<String, dynamic>?),
  diameter: _diameterFromJson(json['diameter'] as Map<String, dynamic>?),
  mass: _massFromJson(json['mass'] as Map<String, dynamic>?),
);

Map<String, dynamic> _$RocketToJson(Rocket instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'type': instance.type,
  'description': instance.description,
  'wikipedia': instance.wikipedia,
  'height': _heightToJson(instance.height),
  'diameter': _diameterToJson(instance.diameter),
  'mass': _massToJson(instance.mass),
};
