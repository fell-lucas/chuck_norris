import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

class FakeCategoryEvent extends Fake implements CategoryEvent {}

class FakeCategoryState extends Fake implements CategoryState {}

class MockJokeBloc extends MockBloc<JokeEvent, JokeState> implements JokeBloc {}

class FakeJokeEvent extends Fake implements JokeEvent {}

class FakeJokeState extends Fake implements JokeState {}

class MockPokemonBloc extends MockBloc<PokemonEvent, PokemonState>
    implements PokemonBloc {}

class FakePokemonEvent extends Fake implements PokemonEvent {}

class FakePokemonState extends Fake implements PokemonState {}

class MockJokeRepository extends Mock implements JokeRepository {}

main() {
  late PokemonBloc pokemonBloc;
  late JokeBloc jokeBloc;
  late CategoryBloc categoryBloc;

  setUpAll(() {
    registerFallbackValue(FakePokemonEvent());
    registerFallbackValue(FakePokemonState());
    registerFallbackValue(FakeCategoryEvent());
    registerFallbackValue(FakeCategoryState());
    registerFallbackValue(FakeJokeEvent());
    registerFallbackValue(FakeJokeState());
  });
  setUp(() {
    pokemonBloc = MockPokemonBloc();
    categoryBloc = MockCategoryBloc();
    jokeBloc = MockJokeBloc();
    when(() => pokemonBloc.state).thenReturn(PokemonInitial());
    when(() => jokeBloc.state).thenReturn(JokeInitial());
  });

  Widget createWidgetUnderTest() {
    return (MaterialApp(
      home: Material(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PokemonBloc>(
              create: (context) => pokemonBloc,
            ),
            BlocProvider<JokeBloc>(
              create: (context) => jokeBloc,
            ),
            BlocProvider<CategoryBloc>(
              create: (context) => categoryBloc,
            ),
          ],
          child: const HomePage(),
        ),
      ),
    ));
  }

  testWidgets('Button in category initial state', (tester) async {
    when(() => categoryBloc.state).thenReturn(CategoryInitial());
    await tester.pumpWidget(createWidgetUnderTest());
    final button = find.byKey(
      const Key('fucking_button'),
    );
    await tester.tap(button);
    expect(button, findsOneWidget);
  });
  testWidgets('Button in category updated state', (tester) async {
    String category = 'random';
    when(() => categoryBloc.state)
        .thenReturn(CategoryUpdated(category: category));
    await tester.pumpWidget(createWidgetUnderTest());
    final button = find.byKey(
      const Key('fucking_button'),
    );
    await tester.tap(button);
    expect(button, findsOneWidget);
  });
}
