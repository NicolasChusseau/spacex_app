import 'lunch_patch.model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'lunch_links.model.g.dart';

@JsonSerializable()
class LunchLinks {
  const LunchLinks ({
    required this.webcast,
    required this.article,
    required this.wikipedia,
    required this.patch,
  });

  final String? webcast;
  final String? article;
  final String? wikipedia;
  final LunchPatch? patch;

  factory LunchLinks.fromJson(Map<String, dynamic> json) => _$LunchLinksFromJson(json);

  Map<String, dynamic> toJson() => _$LunchLinksToJson(this);

  static LunchLinks mock(int id) => LunchLinks(
    webcast: 'https://www.youtube.com/watch?$id',
    article: 'https://example.com/article/$id',
    wikipedia: 'https://en.wikipedia.org/wiki/SpaceX_Launch_$id',
    patch: LunchPatch.mock(id),
  );
}