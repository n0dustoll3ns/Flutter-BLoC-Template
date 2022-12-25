/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

abstract class CatalogPageState {
  final List<Category> categories;
  CatalogPageState({required this.categories});
}

class CatalogPageInitial extends CatalogPageState {
  CatalogPageInitial({required super.categories});
}

class CatalogPageLoading extends CatalogPageState {
  CatalogPageLoading({required super.categories});
}

class CatalogPageLoadFailure extends CatalogPageState {
  final String error;

  CatalogPageLoadFailure({
    required this.error,
  }) : super(categories: []);

  @override
  String toString() => 'CatalogPageFailure { error: $error }';
}

class CatalogPageLoaded extends CatalogPageState {
  CatalogPageLoaded({required super.categories});
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

class CatalogPageEnter extends CatalogEvent {
  Category? category;
  CatalogPageEnter({this.category});
}
