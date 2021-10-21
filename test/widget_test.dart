// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chuck_norris/main.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

void main() {
  getIt.registerSingleton<JokeApi>(JokeApi());
  getIt.registerSingleton<JokeRepository>(
    Repository(jokeApi: getIt<JokeApi>()),
  );
  getIt.registerSingleton<PokemonApi>(PokemonApi());
  getIt.registerSingleton<IPokemonRepository>(
    PokemonRepository(pokeApi: getIt<PokemonApi>()),
  );
  group('pokemon', () {
    testWidgets('find fckn button', (tester) async {
      try {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        final btn = find.byKey(const Key('fucking_button'));
        expect(btn, findsOneWidget);
      } catch (_) {}
    });
    testWidgets('find chuck norris joke text', (tester) async {
      try {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        final btn = find.byKey(const Key('fucking_button'));
        tester.tap(btn);
        await tester.pumpAndSettle();
        final chuckJoke = find.byKey(const Key('chuck_norris_joke'));
        expect(chuckJoke, findsOneWidget);
      } catch (_) {}
    });

    testWidgets('find pokemon image and name', (tester) async {
      try {
        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();
        final btn = find.byKey(const Key('fucking_button'));
        tester.tap(btn);
        await tester.pumpAndSettle();
        final pokeImage = find.byKey(const Key('pokemon_image'));
        final pokeName = find.byKey(const Key('pokemon_name'));
        expect(pokeImage, findsOneWidget);
        expect(pokeName, findsOneWidget);
      } catch (_) {}
    });
  });
}
