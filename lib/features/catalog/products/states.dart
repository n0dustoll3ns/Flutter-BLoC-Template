/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

abstract class ProductsState {
  ProductsState();
}

class ProductsInitial extends ProductsState {
  ProductsInitial();
}

class ProductsLoading extends ProductsState {
  ProductsLoading();
}

class ProductsFailure extends ProductsState {
  final String error;

  ProductsFailure({required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ProductsUpdated extends ProductsState {
  List<Product> items;
  ProductsUpdated({required this.items});
}

/* ---  Events   --- */

