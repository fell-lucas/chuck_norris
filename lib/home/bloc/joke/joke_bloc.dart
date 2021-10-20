import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:meta/meta.dart';

part 'joke_event.dart';
part 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  final JokeRepository jokeRepository;

  JokeBloc({
    required this.jokeRepository,
  }) : super(JokeInitial());

  Stream<JokeState> _mapFetchJokeByCategoryToState(
    FetchJokeByCategory event,
  ) async* {
    try {
      Joke joke = await jokeRepository.fetchJokeByCategory(
        category: event.category,
      );
      yield JokeLoadSuccessful(joke: joke);
    } on HttpException catch (e) {
      yield JokeError(
        error: e.message,
      );
    }
  }

  Stream<JokeState> _mapFetchJokeToState() async* {
    try {
      Joke joke = await jokeRepository.fetchJoke();
      yield JokeLoadSuccessful(joke: joke);
    } on HttpException catch (e) {
      yield JokeError(
        error: e.message,
      );
    }
  }

  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    {
      yield JokeLoadInProgress();
      if (event is FetchJokeByCategory) {
        yield* _mapFetchJokeByCategoryToState(event);
      } else if (event is FetchJoke) {
        yield* _mapFetchJokeToState();
      }
    }
  }
}
