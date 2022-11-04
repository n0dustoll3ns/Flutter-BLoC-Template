/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CategoriesState {
  final List<CatalogCategory> categories;

  CategoriesState({required this.categories});
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial({required super.categories});
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading({required super.categories});
}

class CategoriesLoadFailure extends CategoriesState {
  final String error;

  CategoriesLoadFailure({required this.error, required super.categories});

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded({required super.categories});
}

/* ---  Events   --- */

abstract class CategoryEvent {
  const CategoryEvent();
}

class ApplicationEntered extends CategoryEvent {
  // final int skipCount;

  const ApplicationEntered();

  @override
  String toString() => 'Products requested.';
}
