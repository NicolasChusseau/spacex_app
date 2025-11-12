// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'launch_links.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaunchLinks _$LaunchLinksFromJson(Map<String, dynamic> json) => LaunchLinks(
  webcast: json['webcast'] as String?,
  article: json['article'] as String?,
  wikipedia: json['wikipedia'] as String?,
  patch: json['patch'] == null
      ? null
      : LaunchPatch.fromJson(json['patch'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LaunchLinksToJson(LaunchLinks instance) =>
    <String, dynamic>{
      'webcast': instance.webcast,
      'article': instance.article,
      'wikipedia': instance.wikipedia,
      'patch': instance.patch,
    };
