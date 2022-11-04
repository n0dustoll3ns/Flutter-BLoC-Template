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
  CatalogCategory? _selectedCategory;

  CatalogCategory? get selectedCategory => _selectedCategory;

  set selectedCategory(CatalogCategory? selectedCategory) {
    _selectedCategory = selectedCategory;
  }

  CategoriesLoaded setCategory(CatalogCategory category) {
    var categoriesLoaded = CategoriesLoaded(categories: categories)..selectedCategory = category;
    return categoriesLoaded;
  }
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

class CategoryChange extends CategoryEvent {
  CategoryChange(this.category);
  final CatalogCategory category;
}
