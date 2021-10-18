part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {}

class UpdateCategory extends CategoryEvent {
  final String category;
  UpdateCategory({
    required this.category,
  });

  @override
  List<Object> get props => [category];
}
