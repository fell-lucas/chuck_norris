import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'official_artwork.g.dart';

@JsonSerializable()
class OfficialArtwork extends Equatable {
  @JsonKey(name: 'front_default')
  final String url;
  const OfficialArtwork({
    required this.url,
  });

  @override
  List<Object?> get props => [url];

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);
  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);
}
