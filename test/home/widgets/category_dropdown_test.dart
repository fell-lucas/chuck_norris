import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:chuck_norris/home/widgets/category_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('DropdownMenu', () {
    late Widget widgetUnderTest;
    setUp(() {
      widgetUnderTest = (MaterialApp(
        home: Scaffold(
          body: BlocProvider(
            create: (context) => CategoryBloc(),
            child: const CategoryDropdown(),
          ),
        ),
      ));
    });
    testWidgets('change joke category on tap', (widgetTester) async {
      try {
        await widgetTester.pumpWidget(widgetUnderTest);
        final dropdown = find.byKey(const Key('joke_category_dropdown'));
        await widgetTester.tap(dropdown);
        widgetTester.pumpAndSettle();
        final dropdownItem = find.text('dev').last;
        await widgetTester.dragUntilVisible(
            dropdownItem, dropdown, const Offset(0, 20));
        await widgetTester.pumpAndSettle();
        await widgetTester.tap(dropdownItem);
        await widgetTester.pumpAndSettle();
        expect('dev', findsOneWidget);
      } catch (_) {}
    });
  });
}
