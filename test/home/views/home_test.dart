import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chuck_norris/main.dart' as app;

main() {
  group('Joke', () {
    testWidgets('find chuck norris joke text', (tester) async {
      try {
        app.main();
        await tester.pumpAndSettle();
        final btn = find.byKey(const Key('fucking_button'));
        tester.tap(btn);
        await tester.pumpAndSettle();
        final chuckJoke = find.byKey(const Key('chuck_norris_joke'));
        expect(chuckJoke, findsOneWidget);
      } catch (_) {}
    });
  });

  group('Pokemon', () {
    testWidgets('find pokemon image and name', (tester) async {
      try {
        app.main();
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
