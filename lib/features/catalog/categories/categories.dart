/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CatalogState {
  final Category category;
  CatalogState({required this.category});
}

class CategoryInitial extends CatalogState {
  CategoryInitial({required super.category});
}

class CategoryLoading extends CatalogState {
  CategoryLoading({required super.category});
}

class CategoryLoadFailure extends CatalogState {
  final String error;

  CategoryLoadFailure({required this.error, required super.category});

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoryLoaded extends CatalogState {
  CategoryLoaded({required super.category});
}

/* ---  Events   --- */

abstract class CatalogEvent {
  const CatalogEvent();
}

class ProductsRequest extends CatalogEvent {
  // final int skipCount;

  const ProductsRequest();

  @override
  String toString() => 'Products requested.';
}

class CategoryPageEnter extends CatalogEvent {
  Category category;
  CategoryPageEnter({required this.category});
}
