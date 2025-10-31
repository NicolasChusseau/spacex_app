import 'package:json_annotation/json_annotation.dart';

part 'lunch_patch.model.g.dart';

@JsonSerializable()
class LunchPatch {
  final String? small;
  final String? large;

  LunchPatch({this.small, this.large});

  factory LunchPatch.fromJson(Map<String, dynamic> json) => _$LunchPatchFromJson(json);

  Map<String, dynamic> toJson() => _$LunchPatchToJson(this);

  static LunchPatch mock(int id) => LunchPatch(
        small: 'https://i.la-croix.com/836x/smart/2023/01/25/1201252298/Nasa-Pentagone-annonce-partenariatelaborer-fusee-propulsee-Mars-lenergie-nucleaire_0.jpg',
        large: 'https://i.la-croix.com/836x/smart/2023/01/25/1201252298/Nasa-Pentagone-annonce-partenariatelaborer-fusee-propulsee-Mars-lenergie-nucleaire_0.jpg',
      );
}
