import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  Stream<CategoryState> _mapUpdateCategoryToState(UpdateCategory event) async* {
    if (event.category != 'random') {
      yield CategoryUpdated(category: event.category);
    } else {
      yield CategoryInitial();
    }
  }

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if (event is UpdateCategory) {
      yield* _mapUpdateCategoryToState(event);
    }
  }
}
