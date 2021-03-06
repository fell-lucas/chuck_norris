import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon_repository/pokemon_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

main() {
  late http.Client mockedClient;
  late Map<String, http.Response> mockedResponses;
  late PokemonApi api;
  late int pokeNumber;

  setUp(() {
    pokeNumber = 1;
    mockedClient = MockHttpClient();
    mockedResponses = {
      'success': http.Response(
        '{"id": 1, "name": "abc", "sprites": {"other": {"official-artwork": {"front_default": "http://hi.com",}}}}',
        200,
      ),
      'error': http.Response(
        '{"id": 1, "name": "abc", "sprites": {"other": {"official-artwork": {"front_default": "http://hi.com"}}}}',
        404,
      )
    };
    api = PokemonApi(client: mockedClient);
    registerFallbackValue(Uri.parse(''));
  });
  group('FetchSprite', () {
    test('Success', () async {
      when(
        () => mockedClient.get(any()),
      ).thenAnswer((_) async => mockedResponses['success']!);
      Pokemon pokemon = await api.fetchPokemon(pokeNumber: 1);
      expect(
        pokemon,
        Pokemon.fromJson(jsonDecode(mockedResponses['success']!.body)),
      );
    });
    test('Error', () async {
      when(
        () => mockedClient.get(any()),
      ).thenAnswer((_) async => mockedResponses['error']!);
      expect(
        () async => await api.fetchPokemon(pokeNumber: pokeNumber),
        throwsA(isA<HttpException>()),
      );
    });

    test('should make api call', () async {
      when(() => mockedClient.get(Uri.parse('$kApiUrl/$pokeNumber')))
          .thenAnswer((_) async => mockedResponses['success']!);
      await api.fetchPokemon(pokeNumber: pokeNumber);
      verify(() => mockedClient.get(Uri.parse('$kApiUrl/$pokeNumber')))
          .called(1);
    });
  });

  test('ToJson', () async {
    when(
      () => mockedClient.get(any()),
    ).thenAnswer((_) async => mockedResponses['success']!);
    Pokemon pokemon = await api.fetchPokemon(pokeNumber: pokeNumber);
    Map<String, dynamic> json = pokemon.toJson();
    expect(pokemon == Pokemon.fromJson(json), isTrue);
  });
}
