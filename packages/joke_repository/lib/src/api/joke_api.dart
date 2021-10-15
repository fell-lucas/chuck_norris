import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:joke_repository/src/api/models/models.dart';

const String kApiUrl = 'https://api.chucknorris.io/jokes/random';

class JokeApi {
  final http.Client _client;

  JokeApi({http.Client? client}) : _client = client ?? http.Client();

  Future<Joke> fetchJoke() async {
    final result = await _client.get(Uri.parse(kApiUrl));

    if (result.statusCode != 200) {
      throw result.statusCode;
    }

    return Joke.fromJson(jsonDecode(result.body));
  }
}
