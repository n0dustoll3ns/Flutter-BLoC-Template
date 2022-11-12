/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CatalogState {
  CatalogState();
}

class CategoryInitial extends CatalogState {
  CategoryInitial();
}

class CategoryLoading extends CatalogState {
  CategoryLoading();
}

class CategoryLoadFailure extends CatalogState {
  final String error;

  CategoryLoadFailure({required this.error});

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class CategoryLoaded extends CatalogState {
  final Category category;
  CategoryLoaded({required this.category});
}

/* ---  Events   --- */

abstract class CatalogEvent {
  const CatalogEvent();
}

class ApplicationStarted extends CatalogEvent {
  // final int skipCount;

  const ApplicationStarted();

  @override
  String toString() => 'Products requested.';
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
