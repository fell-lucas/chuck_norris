part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {}

class PokemonInitial extends PokemonState {
  @override
  List<Object?> get props => [];
}

class PokemonLoadInProgress extends PokemonState {
  @override
  List<Object?> get props => [];
}

class PokemonLoadSuccessful extends PokemonState {
  final Pokemon poke;
  PokemonLoadSuccessful({
    required this.poke,
  });
  @override
  List<Object?> get props => [poke];
}

class PokemonError extends PokemonState {
  final String error;
  PokemonError({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
