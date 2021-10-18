part of 'joke_bloc.dart';

@immutable
abstract class JokeState extends Equatable {}

class JokeInitial extends JokeState {
  @override
  List<Object?> get props => [];
}

class JokeLoadInProgress extends JokeState {
  @override
  List<Object?> get props => [];
}

class JokeLoadSuccessful extends JokeState {
  final Joke joke;

  JokeLoadSuccessful({
    required this.joke,
  });

  @override
  List<Object?> get props => [joke];
}

class JokeError extends JokeState {
  final String error;
  JokeError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
