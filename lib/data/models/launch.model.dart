import 'launch_links.model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'launch.model.g.dart';

@JsonSerializable()
class Launch {
  const Launch({
    required this.id,
    required this.name,
    required this.details,
    required this.rocket,
    required this.dateUtc,
    required this.success,
    required this.links,
  });

  final String id;
  final String name;
  final String? details;
  final String rocket;
  @JsonKey(name: "date_utc")
  final DateTime? dateUtc;
  final bool? success;

  final LaunchLinks? links;

  factory Launch.fromJson(Map<String, dynamic> json) => _$LaunchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchToJson(this);

  static Launch mock({
    int id = 1,
  }) =>
      Launch(
        id: '$id',
        name: 'Launch $id',
        details: 'Details of launch $id',
        rocket: 'Rocket $id',
        dateUtc: DateTime.now().subtract(Duration(days: id * 10)),
        success: id % 2 == 0,
        links: LaunchLinks.mock(id)
      );

  static List<Launch> mocks() => List<Launch>.generate(
    50,
        (int index) => mock(id: index + 1),
  );
}