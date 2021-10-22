import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

class MockPokemonApi extends Mock implements PokemonApi {}

void main() {
  late PokemonApi api;
  late PokemonRepository repository;
  Pokemon pokemon = Pokemon(id: 1, name: 'abc', sprites: 'abc');

  setUp(() {
    api = MockPokemonApi();
    repository = PokemonRepository(pokeApi: api);
  });
  group('FetchSprite', () {
    int pokeNumber = 1;
    test('Fetch pokemon sprite', () async {
      when(() => api.fetchPokemon(pokeNumber: pokeNumber))
          .thenAnswer((_) async => pokemon);
      Pokemon repositoryPokemon =
          await repository.fetchPokemon(pokeNumber: pokeNumber);
      expect(repositoryPokemon, pokemon);
    });
  });
}
