part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {}

class FetchSprite extends PokemonEvent {
  final int pokeNumber;
  FetchSprite({
    required this.pokeNumber,
  });

  @override
  List<Object?> get props => [];
}

class FetchColors extends PokemonEvent {
  @override
  List<Object?> get props => [];
}
