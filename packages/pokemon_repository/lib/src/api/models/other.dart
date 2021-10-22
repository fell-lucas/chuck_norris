import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:pokemon_repository/src/api/models/models.dart';

part 'other.g.dart';

@JsonSerializable()
class Other extends Equatable {
  @JsonKey(name: 'official-artwork')
  final OfficialArtwork officialArtwork;
  const Other({
    required this.officialArtwork,
  });

  @override
  List<Object?> get props => throw [officialArtwork];

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);
  Map<String, dynamic> toJson() => _$OtherToJson(this);
}
