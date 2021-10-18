part of 'pokemon_bloc.dart';

abstract class PokemonEvent extends Equatable {}

class FetchSprite extends PokemonEvent {
  @override
  List<Object?> get props => [];
}
