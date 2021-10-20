import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository pokemonRepository;

  PokemonBloc({
    required this.pokemonRepository,
  }) : super(PokemonInitial());

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    if (event is FetchSprite) {
      try {
        yield PokemonLoadInProgress();
        Pokemon poke = await pokemonRepository.fetchPokemon();
        yield PokemonLoadSuccessful(poke: poke);
      } catch (e) {
        yield PokemonError(error: 'Algo deu errado. Tente novamente.');
      }
    } else if (event is FetchColors) {}
  }
}
