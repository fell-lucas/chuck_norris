import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joke_repository/joke_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockJokeBloc extends MockBloc<JokeEvent, JokeState> implements JokeBloc {}

class FakeJokeEvent extends Fake implements JokeEvent {}

class FakeJokeState extends Fake implements JokeState {}

main() {
  late JokeBloc jokeBloc;

  setUpAll(() {
    registerFallbackValue(FakeJokeEvent());
    registerFallbackValue(FakeJokeState());
  });

  setUp(() {
    jokeBloc = MockJokeBloc();
  });

  Widget createWidgetUnderTest() {
    return (MaterialApp(
      home: Material(
        child: BlocProvider<JokeBloc>(
          create: (context) => jokeBloc,
          child: const JokeText(),
        ),
      ),
    ));
  }

  tearDown(() {
    jokeBloc.close();
  });

  testWidgets('JokeInitial', (tester) async {
    when(() => jokeBloc.state).thenReturn(JokeInitial());
    await tester.pumpWidget(createWidgetUnderTest());
    final initialText = find.byKey(const Key('initial_joke_text'));
    expect(initialText, findsOneWidget);
  });
  testWidgets('JokeLoadInProgress', (tester) async {
    when(() => jokeBloc.state).thenReturn(JokeLoadInProgress());
    await tester.pumpWidget(createWidgetUnderTest());
    final loadingIndicator = find.byKey(
      const Key('loadInProgress_joke_indicator'),
    );
    expect(loadingIndicator, findsOneWidget);
  });
  testWidgets('JokeError', (tester) async {
    String error = 'joke error message';
    when(() => jokeBloc.state).thenReturn(JokeError(error: error));
    await tester.pumpWidget(createWidgetUnderTest());
    final errorText = find.byKey(
      const Key('error_joke_text'),
    );
    expect(errorText, findsOneWidget);
    expect(find.text(error), findsOneWidget);
  });
  testWidgets('JokeLoadSuccessful', (tester) async {
    Joke joke = const Joke(id: '1', description: 'joke');
    when(() => jokeBloc.state).thenReturn(JokeLoadSuccessful(joke: joke));
    await tester.pumpWidget(createWidgetUnderTest());
    final jokeText = find.byKey(
      const Key('chuck_norris_joke'),
    );
    expect(jokeText, findsOneWidget);
    expect(find.text(joke.description), findsOneWidget);
  });
}
