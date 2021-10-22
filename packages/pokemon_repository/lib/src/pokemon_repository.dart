import 'package:pokemon_repository/pokemon_repository.dart';
import 'package:pokemon_repository/src/api/models/models.dart';

abstract class IPokemonRepository {
  Future<Pokemon> fetchPokemon({required int pokeNumber});
}

class PokemonRepository extends IPokemonRepository {
  final PokemonApi pokeApi;
  PokemonRepository({
    required this.pokeApi,
  });

  @override
  Future<Pokemon> fetchPokemon({required int pokeNumber}) {
    return pokeApi.fetchPokemon(pokeNumber: pokeNumber);
  }
}
