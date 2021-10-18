part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {}

class CategoryInitial extends CategoryState {
  @override
  List<Object?> get props => [];
}

class CategoryUpdated extends CategoryState {
  final String category;

  CategoryUpdated({
    required this.category,
  });

  @override
  List<Object?> get props => [category];
}
