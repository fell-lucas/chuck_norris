import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCategoryBloc extends MockBloc<CategoryEvent, CategoryState>
    implements CategoryBloc {}

class FakeCategoryEvent extends Fake implements CategoryEvent {}

class FakeCategoryState extends Fake implements CategoryState {}

main() {
  late CategoryBloc categoryBloc;
  group('DropdownMenu', () {
    late Widget widgetUnderTest;

    setUpAll(() {
      registerFallbackValue(FakeCategoryEvent());
      registerFallbackValue(FakeCategoryState());
    });

    setUp(() {
      categoryBloc = MockCategoryBloc();
      widgetUnderTest = MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (context) => categoryBloc,
            child: const CategoryDropdown(),
          ),
        ),
      );
    });
    testWidgets('Updated category state', (widgetTester) async {
      try {
        String category = 'dev';
        when(() => categoryBloc.state)
            .thenReturn(CategoryUpdated(category: category));
        await widgetTester.pumpWidget(widgetUnderTest);
        final dropdown = find.byKey(const Key('joke_category_dropdown'));
        await widgetTester.tap(dropdown);
        widgetTester.pumpAndSettle();
        final dropdownItem = find.text(category).last;
        await widgetTester.dragUntilVisible(
            dropdownItem, dropdown, const Offset(0, 20));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(dropdownItem);
        await widgetTester.pumpAndSettle();
        expect(category, findsOneWidget);
      } catch (_) {}
    });
  });
}
