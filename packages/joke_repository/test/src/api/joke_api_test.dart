import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

class MockHttpResponse extends Mock implements http.Response {}

main() {
  late http.Client mockedClient;
  late http.Response mockedResponse;
  late JokeApi api;

  setUp(() {
    mockedClient = MockHttpClient();
    mockedResponse = http.Response('{"id": "1", "value": "abc"}', 200);
    api = JokeApi(client: mockedClient);
    registerFallbackValue(Uri.parse(''));
  });
  group('FetchJoke', () {
    group('Random joke', () {
      test('Success', () async {
        when(
          () => mockedClient.get(any()),
        ).thenAnswer((_) async => mockedResponse);
        Joke joke = await api.fetchJoke();
        expect(joke, Joke.fromJson(jsonDecode(mockedResponse.body)));
      });
      test('Error', () {
        try {} catch (e) {}
      });
    });
  });
}
