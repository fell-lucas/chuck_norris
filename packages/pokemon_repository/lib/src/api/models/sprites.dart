import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_repository/src/api/models/models.dart';

part 'sprites.g.dart';

@JsonSerializable()
class Sprites extends Equatable {
  final Other other;
  const Sprites({
    required this.other,
  });

  @override
  List<Object?> get props => [other];

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);
  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}
