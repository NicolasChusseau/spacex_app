// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunch_links.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LunchLinks _$LunchLinksFromJson(Map<String, dynamic> json) => LunchLinks(
  webcast: json['webcast'] as String?,
  article: json['article'] as String?,
  wikipedia: json['wikipedia'] as String?,
  patch: json['patch'] == null
      ? null
      : LunchPatch.fromJson(json['patch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LunchLinksToJson(LunchLinks instance) =>
    <String, dynamic>{
      'webcast': instance.webcast,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
      'patch': instance.patch,
    };
