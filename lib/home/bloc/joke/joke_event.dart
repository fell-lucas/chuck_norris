part of 'joke_bloc.dart';

@immutable
abstract class JokeEvent extends Equatable {}

class FetchJoke extends JokeEvent {
  @override
  List<Object?> get props => [];
}

class FetchJokeByCategory extends JokeEvent {
  final String category;
  FetchJokeByCategory({
    required this.category,
  });

  @override
  List<Object?> get props => [category];
}
