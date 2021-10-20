import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockJokeRepository extends Mock implements JokeRepository {}

main() {
  late JokeRepository jokeRepository;
  late JokeBloc jokeBloc;

  setUp(() {
    jokeRepository = MockJokeRepository();
    jokeBloc = JokeBloc(jokeRepository: jokeRepository);
  });

  tearDown(() {
    jokeBloc.close();
  });

  group('JokeBloc', () {
    Joke joke = Joke(id: '1', description: 'abc');
    String error = 'error';
    test('Check if JokeInitial is initialized as first state', () {
      expect(jokeBloc.state, JokeInitial());
    });
    group('FetchJoke', () {
      blocTest<JokeBloc, JokeState>(
        'emits [JokeLoadInProgress, JokeLoadSuccessful] when FetchJoke is added.',
        build: () {
          when(() => jokeRepository.fetchJoke()).thenAnswer((_) async => joke);
          return jokeBloc;
        },
        act: (bloc) => bloc.add(FetchJoke()),
        expect: () => <JokeState>[
          JokeLoadInProgress(),
          JokeLoadSuccessful(joke: joke),
        ],
      );
      blocTest<JokeBloc, JokeState>(
        'emits [JokeLoadInProgress, JokeError] when FetchJoke is added.',
        build: () {
          when(() => jokeRepository.fetchJoke())
              .thenThrow(HttpException(error));
          return jokeBloc;
        },
        act: (bloc) => bloc.add(FetchJoke()),
        expect: () => <JokeState>[
          JokeLoadInProgress(),
          JokeError(error: error),
        ],
      );
    });
    group('FetchJokeByCategory', () {
      String category = 'dev';
      blocTest<JokeBloc, JokeState>(
        'emits [JokeLoadInProgress, JokeLoadSuccessful] when FetchJokeByCategory is added.',
        build: () {
          when(() => jokeRepository.fetchJokeByCategory(category: category))
              .thenAnswer((_) async => joke);
          return jokeBloc;
        },
        act: (bloc) => bloc.add(FetchJokeByCategory(category: category)),
        expect: () =>
            <JokeState>[JokeLoadInProgress(), JokeLoadSuccessful(joke: joke)],
      );

      blocTest<JokeBloc, JokeState>(
        'emits [JokeLoadInProgress] when FetchJokeByCategory is added.',
        build: () {
          when(() => jokeRepository.fetchJokeByCategory(category: category))
              .thenThrow(HttpException(error));
          return jokeBloc;
        },
        act: (bloc) => bloc.add(FetchJokeByCategory(category: category)),
        expect: () => <JokeState>[
          JokeLoadInProgress(),
          JokeError(error: error),
        ],
      );
    });
  });
}
