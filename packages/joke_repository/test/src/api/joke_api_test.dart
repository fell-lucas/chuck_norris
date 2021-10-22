import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

main() {
  late http.Client mockedClient;
  late Map<String, http.Response> mockedResponses;
  late JokeApi api;

  setUp(() {
    mockedClient = MockHttpClient();
    mockedResponses = {
      'success': http.Response('{"id": "1", "value": "abc"}', 200),
      'error': http.Response('{"id": "1", "value": "abc"}', 404)
    };
    api = JokeApi(client: mockedClient);
    registerFallbackValue(Uri.parse(''));
  });
  group('FetchJoke', () {
    group('Random joke', () {
      test('Success', () async {
        when(
          () => mockedClient.get(any()),
        ).thenAnswer((_) async => mockedResponses['success']!);
        Joke joke = await api.fetchJoke();
        expect(
          joke,
          Joke.fromJson(jsonDecode(mockedResponses['success']!.body)),
        );
      });
      test('Error', () async {
        when(
          () => mockedClient.get(any()),
        ).thenAnswer((_) async => mockedResponses['error']!);
        expect(
          () async => await api.fetchJoke(),
          throwsA(isA<HttpException>()),
        );
      });
    });

    group('Specific joke', () {
      String category = 'cat';
      test('Success', () async {
        when(
          () => mockedClient.get(any()),
        ).thenAnswer((_) async => mockedResponses['success']!);
        Joke joke = await api.fetchJoke(category: category);
        expect(
          joke,
          Joke.fromJson(jsonDecode(mockedResponses['success']!.body)),
        );
      });
      test('Error', () async {
        when(
          () => mockedClient.get(any()),
        ).thenAnswer((_) async => mockedResponses['error']!);
        expect(
          () async => await api.fetchJoke(category: category),
          throwsA(isA<HttpException>()),
        );
      });
    });
  });
}
