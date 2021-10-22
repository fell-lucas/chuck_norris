import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'joke.g.dart';

@JsonSerializable()
class Joke extends Equatable {
  final String id;
  final String description;
  const Joke({
    required this.id,
    required this.description,
  });

  factory Joke.fromJson(Map<String, dynamic> json) => _$JokeFromJson(json);
  Map<String, dynamic> toJson() => _$JokeToJson(this);

  @override
  List<Object?> get props => [id, description];
}
