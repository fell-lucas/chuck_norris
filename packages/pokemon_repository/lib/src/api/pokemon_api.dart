import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:pokemon_repository/src/api/models/models.dart';

const kApiUrl = 'https://pokeapi.co/api/v2/pokemon/';
const kApiColorUrl = 'https://pokeapi.co/api/v2/pokemon-color/';

class PokemonApi {
  final http.Client _client;
  PokemonApi({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Pokemon> fetchPokemon({required int pokeNumber}) async {
    final result = await _client.get(
      Uri.parse('$kApiUrl/$pokeNumber'),
    );

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    return Pokemon.fromJson(jsonDecode(result.body));
  }
}
