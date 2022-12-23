/* ---  States   --- */

import '../catalog/categories/model/model.dart';

abstract class PopularCategoriesState {
  final List<Category> categories;
  PopularCategoriesState({required this.categories});
}

class PopularCategoriesInitial extends PopularCategoriesState {
  PopularCategoriesInitial({required super.categories});
}

class PopularCategoriesLoading extends PopularCategoriesState {
  PopularCategoriesLoading({required super.categories});
}

class PopularCategoriesLoadFailure extends PopularCategoriesState {
  final String error;

  PopularCategoriesLoadFailure({
    required this.error,
  }) : super(categories: []);

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class PopularCategoriesLoaded extends PopularCategoriesState {
  PopularCategoriesLoaded({required super.categories});
}

/* ---  Events   --- */

abstract class PopularCategoriesEvent {
  const PopularCategoriesEvent();
}

class Authorized extends PopularCategoriesEvent {
  final String token;
  const Authorized({required this.token});
}
