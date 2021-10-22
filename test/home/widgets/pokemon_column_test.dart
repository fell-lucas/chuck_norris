import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokemon_repository/pokemon_repository.dart';

class MockPokemonBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

class FakePokemonEvent extends Fake implements PokemonEvent {}

class FakePokemonState extends Fake implements PokemonState {}

class MockSprites extends Mock implements Sprites {}

main() {
  late PokemonBloc pokemonBloc;
  late Sprites fakeSprites;

  setUpAll(() {
    HttpOverrides.global = null;
    registerFallbackValue(FakePokemonEvent());
    registerFallbackValue(FakePokemonState());
  });

  setUp(() {
    pokemonBloc = MockPokemonBloc();
    fakeSprites = MockSprites();
  });

  Widget createWidgetUnderTest() {
    return (MaterialApp(
      home: Material(
        child: BlocProvider<PokemonBloc>(
          create: (context) => pokemonBloc,
          child: const PokemonColumn(),
        ),
      ),
    ));
  }

  tearDown(() {
    pokemonBloc.close();
  });

  testWidgets('PokemonInitial', (tester) async {
    when(() => pokemonBloc.state).thenReturn(PokemonInitial());
    await tester.pumpWidget(createWidgetUnderTest());
    final initialText = find.byKey(const Key('initial_pokemon_text'));
    expect(initialText, findsOneWidget);
  });
  testWidgets('PokemonLoadInProgress', (tester) async {
    when(() => pokemonBloc.state).thenReturn(PokemonLoadInProgress());
    await tester.pumpWidget(createWidgetUnderTest());
    final loadingIndicator = find.byKey(
      const Key('loadInProgress_pokemon_indicator'),
    );
    expect(loadingIndicator, findsOneWidget);
  });
  testWidgets('PokemonError', (tester) async {
    String error = 'pokemon error message';
    when(() => pokemonBloc.state).thenReturn(PokemonError(error: error));
    await tester.pumpWidget(createWidgetUnderTest());
    final errorText = find.byKey(
      const Key('error_pokemon_text'),
    );
    expect(errorText, findsOneWidget);
    expect(find.text(error), findsOneWidget);
  });
  testWidgets('PokemonLoadSuccessful', (tester) async {
    when(() => fakeSprites.other).thenReturn(
      const Other(
        officialArtwork: OfficialArtwork(url: 'http://example.com/abc'),
      ),
    );
    Pokemon pokemon = Pokemon(id: 1, name: 'abc', sprites: fakeSprites);
    when(() => pokemonBloc.state).thenReturn(
      PokemonLoadSuccessful(poke: pokemon),
    );
    await tester.pumpWidget(createWidgetUnderTest());
    final pokeImage = find.byKey(const Key('pokemon_image'));
    final pokeName = find.byKey(const Key('pokemon_name'));
    expect(pokeImage, findsOneWidget);
    expect(pokeName, findsOneWidget);
    expect(find.text(pokemon.name.toTitleCase() + ' Norris'), findsOneWidget);
  });
}
