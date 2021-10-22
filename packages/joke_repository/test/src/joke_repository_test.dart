import 'package:flutter_test/flutter_test.dart';

import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockJokeApi extends Mock implements JokeApi {}

void main() {
  late JokeApi api;
  late JokeRepository repository;
  Joke joke = Joke(id: '1', description: 'abc');

  setUp(() {
    api = MockJokeApi();
    repository = Repository(jokeApi: api);
  });
  group('FetchJoke', () {
    test('Fetch random joke', () async {
      when(() => api.fetchJoke()).thenAnswer((_) async => joke);
      Joke repositoryJoke = await repository.fetchJoke();
      expect(repositoryJoke, joke);
    });

    test('Fetch joke by category', () async {
      String category = 'abc';
      when(
        () => api.fetchJoke(category: category),
      ).thenAnswer((_) async => joke);
      Joke repositoryJoke = await repository.fetchJokeByCategory(
        category: category,
      );
      expect(repositoryJoke, joke);
    });
  });
}
