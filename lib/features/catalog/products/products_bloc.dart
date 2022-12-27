import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

import '../categories/model/model.dart';

class CatalogPageProductsBloc extends Bloc<ProductEvent, ProductsState> {
  CatalogPageProductsBloc() : super(ProductsLoading(items: [])) {
    on<RequestMoreProducts>(loadItems);
  }
  ProductsRepository productsRepository = ProductsRepository();

  Future<void> loadItems(RequestMoreProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading(items: state.items));
    try {
      var products = await productsRepository.getProductList(
          token: 'token', productIds: event.category?.productIds ?? [], skipCount: state.items.length);

      state.items.addAll(products);
      emit(ProductsUpdated(items: state.items));
    } on Exception catch (_) {
      emit(ProductsFailure('Error loading products'));
    }
  }
}

/* ---  States   --- */
abstract class ProductsState {
  final List<Product> items;

  ProductsState({required this.items});
}

class ProductsLoading extends ProductsState {
  ProductsLoading({required super.items});
}

class ProductsUpdated extends ProductsState {
  ProductsUpdated({required super.items});
}

class ProductsFailure extends ProductsState {
  final String errorMessage;
  ProductsFailure(this.errorMessage) : super(items: []);
}

/* ---  Events   --- */

abstract class ProductEvent {
  const ProductEvent();
}

class RequestMoreProducts extends ProductEvent {
  Category? category;
  RequestMoreProducts({this.category});
}
