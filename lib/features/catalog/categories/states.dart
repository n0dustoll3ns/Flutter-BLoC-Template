/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

import '../products/model/product.dart';

abstract class CatalogPageState {
  final List<Category> categories;
  final List<Product> items;
  CatalogPageState({
    required this.categories,
    required this.items,
  });
}

class CatalogPageInitial extends CatalogPageState {
  CatalogPageInitial({required super.categories, required super.items});
}

class CatalogPageLoading extends CatalogPageState {
  CatalogPageLoading({required super.categories, required super.items});
}

class CatalogPageLoadFailure extends CatalogPageState {
  final String error;

  CatalogPageLoadFailure({
    required this.error,
  }) : super(categories: [], items: []);

  @override
  String toString() => 'CatalogPageFailure { error: $error }';
}

class CatalogPageLoaded extends CatalogPageState {
  CatalogPageLoaded({required super.categories, required super.items});
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
