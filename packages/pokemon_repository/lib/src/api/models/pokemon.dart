import 'package:json_annotation/json_annotation.dart';

part 'pokemon.g.dart';

@JsonSerializable()
class Pokemon {
  final String name;
  final String img;
  Pokemon({
    required this.name,
    required this.img,
  });
}
