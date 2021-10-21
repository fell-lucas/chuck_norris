import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_repository/pokemon_repository.dart';
import 'package:pokemon_repository/src/api/api.dart';

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

const kApiUrl = 'https://pokeapi.co/api/v2/pokemon/';

main() {
  late PokemonApi pokeApi;
  late http.Client mockHttp;
  late int pokeNumber;
  late http.Response response;

  setUp(() {
    mockHttp = MockHttpClient();
    pokeApi = PokemonApi(client: mockHttp);
    pokeNumber = 1;
    response = MockHttpResponse();
  });

  group('fetchPokemon', () {
    test('should make api call', () async {
      when(() => mockHttp.get(Uri.parse('$kApiUrl/$pokeNumber')))
          .thenAnswer((_) async => response);
      try {
        await pokeApi.fetchPokemon(pokeNumber: pokeNumber);
      } catch (_) {}
      verify(() => mockHttp.get(Uri.parse('$kApiUrl/$pokeNumber'))).called(1);
    });
  });
}
