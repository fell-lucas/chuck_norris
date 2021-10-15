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
        yield JokeLoadInProgress();
        var joke = await jokeRepository.fetchJoke();
        yield JokeLoadSuccessful(joke: joke);
      }
    }
  }
}
