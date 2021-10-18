import 'package:pokemon_repository/pokemon_repository.dart';
import 'package:pokemon_repository/src/api/models/models.dart';

abstract class PokemonRepository {
  Future<Pokemon> fetchPokemon();
}

class PokeRepository extends PokemonRepository {
  final PokemonApi pokeApi;
  PokeRepository({
    required this.pokeApi,
  });

  @override
  Future<Pokemon> fetchPokemon() {
    return pokeApi.fetchPokemon();
  }
}
