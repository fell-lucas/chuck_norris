import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

import 'package:chuck_norris/home/bloc/bloc.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

class MockPokemonRepository extends Mock implements PokemonRepository {
  final PokemonApi pokemonApi;
  MockPokemonRepository({
    required this.pokemonApi,
  });
}

main() {
  int pokeNumber = 1;
  late PokemonApi pokemonApi;
  late PokemonRepository pokemonRepository;
  late PokemonBloc pokemonBloc;

  setUp(() {
    pokemonApi = PokemonApi();
    pokemonRepository = MockPokemonRepository(pokemonApi: pokemonApi);
    pokemonBloc = PokemonBloc(pokemonRepository: pokemonRepository);
  });
  group('PokemonBloc', () {
    test('verify PokemonInitial is initial state', () {
      expect(pokemonBloc.state, PokemonInitial());
    });
    group('FetchSprite', () {
      Pokemon poke = Pokemon(id: 1, name: 'abc', sprites: 'sprites');
      String error = 'error';

      test('verify event equality', () {
        var first = FetchSprite(pokeNumber: pokeNumber);
        var second = FetchSprite(pokeNumber: pokeNumber);
        expect(first == second, isTrue);
      });
      blocTest<PokemonBloc, PokemonState>(
        'emits [PokemonLoadInProgress, PokemonLoadSuccessful] when FetchSprite is added.',
        build: () {
          when(() => pokemonRepository.fetchPokemon(pokeNumber: pokeNumber))
              .thenAnswer((_) async => poke);
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(FetchSprite(pokeNumber: pokeNumber)),
        expect: () => <PokemonState>[
          PokemonLoadInProgress(),
          PokemonLoadSuccessful(poke: poke)
        ],
      );
      blocTest<PokemonBloc, PokemonState>(
        'emits [PokemonLoadInProgress, PokemonError] when FetchSprite is added.',
        build: () {
          when(() => pokemonRepository.fetchPokemon(pokeNumber: pokeNumber))
              .thenThrow(HttpException(error));
          return pokemonBloc;
        },
        act: (bloc) => bloc.add(FetchSprite(pokeNumber: pokeNumber)),
        expect: () => <PokemonState>[
          PokemonLoadInProgress(),
          PokemonError(error: error),
        ],
      );
    });
  });
}
