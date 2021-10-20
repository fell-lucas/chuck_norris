import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_repository/src/api/models/models.dart';

part 'poke_colors.g.dart';

@JsonSerializable()
class PokemonColors {
  @JsonKey(name: 'results')
  final List<PokemonColor> colors;
  PokemonColors({
    required this.colors,
  });

  factory PokemonColors.fromJson(Map<String, dynamic> json) =>
      _$PokemonColorsFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonColorsToJson(this);
}
