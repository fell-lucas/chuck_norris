import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final IPokemonRepository pokemonRepository;

  PokemonBloc({
    required this.pokemonRepository,
  }) : super(PokemonInitial());

  Stream<PokemonState> _mapFetchSpriteToState(FetchSprite event) async* {
    try {
      yield PokemonLoadInProgress();
      Pokemon poke =
          await pokemonRepository.fetchPokemon(pokeNumber: event.pokeNumber);
      yield PokemonLoadSuccessful(poke: poke);
    } on HttpException catch (e) {
      yield PokemonError(error: e.message);
    }
  }

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    if (event is FetchSprite) {
      yield* _mapFetchSpriteToState(event);
    }
    // else if (event is FetchColors) {}
  }
}
