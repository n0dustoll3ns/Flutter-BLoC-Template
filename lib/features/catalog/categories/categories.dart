/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CategoriesState {
  CatalogCategory? _selectedCategory;
  final List<CatalogCategory> categories;

  CatalogCategory? get selectedCategory => _selectedCategory;

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
  set selectedCategory(CatalogCategory? selectedCategory) {
    _selectedCategory = selectedCategory;
  }

  CategoriesLoaded({required super.categories});
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
  final CatalogCategory? category;
}
