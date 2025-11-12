import 'launch_patch.model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'launch_links.model.g.dart';

@JsonSerializable()
class LaunchLinks {
  const LaunchLinks ({
    required this.webcast,
    required this.article,
    required this.wikipedia,
    required this.patch,
  });

  final String? webcast;
  final String? article;
  final String? wikipedia;
  final LaunchPatch? patch;

  factory LaunchLinks.fromJson(Map<String, dynamic> json) => _$LaunchLinksFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchLinksToJson(this);

  static LaunchLinks mock(int id) => LaunchLinks(
    webcast: 'https://www.youtube.com/watch?$id',
    article: 'https://example.com/article/$id',
    wikipedia: 'https://en.wikipedia.org/wiki/SpaceX_Launch_$id',
    patch: LaunchPatch.mock(id),
  );
}