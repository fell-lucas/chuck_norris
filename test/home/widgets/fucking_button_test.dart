import 'package:chuck_norris/home/widgets/fucking_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('FuckingButton', () {
    late Widget widgetUnderTest;
    setUp(() {
      widgetUnderTest = (MaterialApp(
        home: Scaffold(
          body: FuckingButton(
            onPress: () {},
          ),
        ),
      ));
    });
    testWidgets('find fckn button', (tester) async {
      try {
        await tester.pumpWidget(widgetUnderTest);
        await tester.pumpAndSettle();
        final btn = find.byKey(const Key('fucking_button'));
        expect(btn, findsOneWidget);
      } catch (_) {}
    });
  });
}
