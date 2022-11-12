/* ---  States   --- */

import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsFailure extends ProductsState {
  final String error;

  const ProductsFailure({required this.error});

  @override
  String toString() => 'LoginFailure { error: $error }';
}

class ProductsUpdated extends ProductsState {
  List<Product> products;
  ProductsUpdated({required this.products});
}

/* ---  Events   --- */

