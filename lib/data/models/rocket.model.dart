import 'package:json_annotation/json_annotation.dart';

part 'rocket.model.g.dart';

double? _heightFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final dynamic v = json['meters'];
  return v is num ? v.toDouble() : null;
}
Map<String, dynamic>? _heightToJson(double? meters) =>
    meters == null ? null : {'meters': meters};

double? _diameterFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final dynamic v = json['meters'];
  return v is num ? v.toDouble() : null;
}
Map<String, dynamic>? _diameterToJson(double? meters) =>
    meters == null ? null : {'meters': meters};

int? _massFromJson(Map<String, dynamic>? json) {
  if (json == null) return null;
  final dynamic v = json['kg'];
  return v is int ? v : (v is num ? v.toInt() : null);
}
Map<String, dynamic>? _massToJson(int? kg) => kg == null ? null : {'kg': kg};

@JsonSerializable()
class Rocket {
  Rocket({
    required this.id,
    required this.name,
    this.type,
    this.description,
    this.wikipedia,
    this.height,
    this.diameter,
    this.mass,
  });

  final String id;
  final String name;
  final String? type;
  final String? description;
  final String? wikipedia;
  @JsonKey(name: 'height', fromJson: _heightFromJson, toJson: _heightToJson)
  final double? height;
  @JsonKey(name: 'diameter', fromJson: _diameterFromJson, toJson: _diameterToJson)
  final double? diameter;
  @JsonKey(name: 'mass', fromJson: _massFromJson, toJson: _massToJson)
  final int? mass;

  factory Rocket.fromJson(Map<String, dynamic> json) => _$RocketFromJson(json);

  Map<String, dynamic> toJson() => _$RocketToJson(this);

  static mock(int id) => Rocket(
        id: 'rocket_$id',
        name: 'Falcon $id',
        type: 'FT',
        description: 'A mock description for Falcon $id rocket.',
        wikipedia: 'https://en.wikipedia.org/wiki/Falcon_$id',
        height: 70.0 + id,
        diameter: 3.7 + id * 0.1,
        mass: 549054 + id * 1000,
      );
}
