import 'package:joke_repository/src/api/api.dart';
import 'package:joke_repository/src/api/models/models.dart';

abstract class JokeRepository {
  Future<Joke> fetchJoke();
  Future<Joke> fetchJokeByCategory({required String category});
}

class Repository extends JokeRepository {
  final JokeApi jokeApi;

  Repository({
    required this.jokeApi,
  });

  @override
  Future<Joke> fetchJoke() {
    return jokeApi.fetchJoke();
  }

  @override
  Future<Joke> fetchJokeByCategory({required String category}) {
    return jokeApi.fetchJoke(category: category);
  }
}
