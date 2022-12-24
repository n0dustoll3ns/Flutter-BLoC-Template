/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CatalogState {
  final List<Category> categories;
  CatalogState({required this.categories});
}

class CategoryInitial extends CatalogState {
  CategoryInitial({required super.categories});
}

class CategoryLoading extends CatalogState {
  CategoryLoading({required super.categories});
}

class CategoryLoadFailure extends CatalogState {
  final String error;

  CategoryLoadFailure({
    required this.error,
  }) : super(categories: []);

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoryLoaded extends CatalogState {
  CategoryLoaded({required super.categories});
}

/* ---  Events   --- */

abstract class CatalogEvent {
  const CatalogEvent();
}

class ProductsRequest extends CatalogEvent {
  final List<int> productIds;
  const ProductsRequest({required this.productIds});

  @override
  String toString() => 'Products requested.';
}

class CategoryPageEnter extends CatalogEvent {
  Category? category;
  CategoryPageEnter({this.category});
}
