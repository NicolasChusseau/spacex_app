import 'package:json_annotation/json_annotation.dart';

part 'launch_patch.model.g.dart';

@JsonSerializable()
class LaunchPatch {
  final String? small;
  final String? large;

  LaunchPatch({this.small, this.large});

  factory LaunchPatch.fromJson(Map<String, dynamic> json) => _$LaunchPatchFromJson(json);

  Map<String, dynamic> toJson() => _$LaunchPatchToJson(this);

  static LaunchPatch mock(int id) => LaunchPatch(
        small: 'https://i.la-croix.com/836x/smart/2023/01/25/1201252298/Nasa-Pentagone-annonce-partenariatelaborer-fusee-propulsee-Mars-lenergie-nucleaire_0.jpg',
        large: 'https://i.la-croix.com/836x/smart/2023/01/25/1201252298/Nasa-Pentagone-annonce-partenariatelaborer-fusee-propulsee-Mars-lenergie-nucleaire_0.jpg',
      );
}
