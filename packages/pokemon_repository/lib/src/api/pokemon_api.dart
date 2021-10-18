import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:pokemon_repository/src/api/models/models.dart';

const kApiUrl = 'https://pokeapi.co/api/v2/pokemon/';

class PokemonApi {
  final http.Client _client;
  PokemonApi({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<Pokemon> fetchPokemon() async {
    final result = await _client.get(
      Uri.parse('$kApiUrl/${Random().nextInt(620) + 1}'),
    );

    if (result.statusCode != 200) {
      throw result.statusCode;
    }

    return Pokemon.fromJson(jsonDecode(result.body));
  }
}
