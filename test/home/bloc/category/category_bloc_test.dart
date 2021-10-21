import 'package:bloc_test/bloc_test.dart';
import 'package:chuck_norris/home/bloc/bloc.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  late CategoryBloc categoryBloc;

  setUp(() {
    categoryBloc = CategoryBloc();
  });
  group('CategoryBloc', () {
    test('Check if CategoryInitial is initialized as first state', () {
      expect(categoryBloc.state, CategoryInitial());
    });
    group('UpdateCategory', () {
      String ordinaryCategory = 'dev';
      String randomCategory = 'random';

      blocTest<CategoryBloc, CategoryState>(
        'emits [CategoryUpdated] when UpdateCategory is added.',
        build: () => categoryBloc,
        act: (bloc) => bloc.add(UpdateCategory(category: ordinaryCategory)),
        expect: () =>
            <CategoryState>[CategoryUpdated(category: ordinaryCategory)],
      );

      blocTest<CategoryBloc, CategoryState>(
        'emits [CategoryInitial] when UpdateCategory is added with "random".',
        build: () => categoryBloc,
        act: (bloc) => bloc.add(UpdateCategory(category: randomCategory)),
        expect: () => <CategoryState>[CategoryInitial()],
      );

      test('checks for event equality', () {
        var first = UpdateCategory(category: ordinaryCategory);
        var second = UpdateCategory(category: ordinaryCategory);

        expect(first == second, isTrue);
      });
    });
  });
}
