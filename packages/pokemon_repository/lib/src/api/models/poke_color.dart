import 'package:json_annotation/json_annotation.dart';

part 'poke_color.g.dart';

@JsonSerializable()
class PokemonColor {
  final String name;
  final String url;
  PokemonColor({
    required this.name,
    required this.url,
  });

  factory PokemonColor.fromJson(Map<String, dynamic> json) =>
      _$PokemonColorFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonColorToJson(this);
}
