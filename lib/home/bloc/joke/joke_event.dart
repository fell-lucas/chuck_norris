part of 'joke_bloc.dart';

@immutable
abstract class JokeEvent extends Equatable {}

class FetchJoke extends JokeEvent {
  final String category;
  FetchJoke({
    this.category = '',
  });

  @override
  List<Object?> get props => [category];
}
