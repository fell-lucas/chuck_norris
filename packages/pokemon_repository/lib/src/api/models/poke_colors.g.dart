// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_colors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonColors _$PokemonColorsFromJson(Map<String, dynamic> json) =>
    PokemonColors(
      colors: (json['results'] as List<dynamic>)
          .map((e) => PokemonColor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonColorsToJson(PokemonColors instance) =>
    <String, dynamic>{
      'results': instance.colors,
    };
