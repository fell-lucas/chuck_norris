import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:joke_repository/src/api/models/models.dart';

const String kApiUrl = 'https://api.chucknorris.io/jokes/random';

class JokeApi {
  final http.Client _client;

  JokeApi({http.Client? client}) : _client = client ?? http.Client();

  Future<Joke> fetchJoke({String? category}) async {
    final result = await _client.get(
      Uri.parse(category != null ? '$kApiUrl?category=$category' : kApiUrl),
    );

    if (result.statusCode != 200) {
      throw const HttpException('Erro ao conectar com a API.');
    }

    return Joke.fromJson(jsonDecode(result.body));
  }
}
