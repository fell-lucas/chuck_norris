import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon extends Equatable {
  final int id;
  final String name;
  final dynamic sprites;
  const Pokemon({
    required this.id,
    required this.name,
    required this.sprites,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) =>
      _$PokemonFromJson(json);
  Map<String, dynamic> toJson() => _$PokemonToJson(this);

  @override
  List<Object?> get props => [id, name, sprites];
}
