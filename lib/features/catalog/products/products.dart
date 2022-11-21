/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

abstract class ProductsState {
  List<Product> products;
  ProductsState({required this.products});
}

class ProductsInitial extends ProductsState {
  ProductsInitial() : super(products: []);
}

class ProductsLoading extends ProductsState {
  ProductsLoading({required super.products});
}

class ProductsFailure extends ProductsState {
  final String error;

  ProductsFailure({required this.error}) : super(products: []);

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ProductsUpdated extends ProductsState {
  ProductsUpdated({required super.products});
}

/* ---  Events   --- */

