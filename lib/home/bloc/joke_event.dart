part of 'joke_bloc.dart';

@immutable
abstract class JokeEvent extends Equatable {}

class FetchJoke extends JokeEvent {
  @override
  List<Object?> get props => [];
}
