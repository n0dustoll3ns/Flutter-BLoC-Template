/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoadFailure extends CategoriesState {
  final String error;

  const CategoriesLoadFailure({required this.error});

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoriesLoaded extends CategoriesState {
  final List<CatalogCategory> categories;

  CategoriesLoaded({required this.categories});
}

/* ---  Events   --- */

abstract class CategoryEvent {
  const CategoryEvent();
}

class CategoryRequest extends CategoryEvent {
  // final int skipCount;

  const CategoryRequest();

  @override
  String toString() => 'Products requested.';
}

class ApplicationEnter extends CategoryEvent {}
