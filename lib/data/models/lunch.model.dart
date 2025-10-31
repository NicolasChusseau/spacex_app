import 'lunch_links.model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'lunch.model.g.dart';

@JsonSerializable()
class Lunch {
  const Lunch({
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

  final LunchLinks? links;

  factory Lunch.fromJson(Map<String, dynamic> json) => _$LunchFromJson(json);

  Map<String, dynamic> toJson() => _$LunchToJson(this);

  static Lunch mock({
    int id = 1,
  }) =>
      Lunch(
        id: '$id',
        name: 'Lunch $id',
        details: 'Details of lunch $id',
        rocket: 'Rocket $id',
        dateUtc: DateTime.now().subtract(Duration(days: id * 10)),
        success: id % 2 == 0,
        links: LunchLinks.mock(id)
      );

  static List<Lunch> mocks() => List<Lunch>.generate(
    50,
        (int index) => mock(id: index + 1),
  );
}