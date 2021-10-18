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

  @override
  Stream<JokeState> mapEventToState(
    JokeEvent event,
  ) async* {
    {
      if (event is FetchJoke) {
        try {
          yield JokeLoadInProgress();
          Joke joke = await jokeRepository.fetchJoke(category: event.category);
          yield JokeLoadSuccessful(joke: joke);
        } catch (_) {
          yield JokeError(error: 'Algo deu errado. Tente novamente.');
        }
      }
    }
  }
}
