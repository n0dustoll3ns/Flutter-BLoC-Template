import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

import '../categories/states.dart';
import 'model/product.dart';
import 'states.dart';

class ProductsBloc extends Bloc<CatalogEvent, ProductsState> {
  final ProductsRepository productsRepository = ProductsRepository();
  final UserRepository userRepository;
  ProductsBloc({
    required this.userRepository,
  }) : super(ProductsInitial()) {
    on<ProductsRequest>(_loadMoreProducts);
  }

  Future<List<Product>?> _loadMoreProducts(
    ProductsRequest event,
    Emitter<ProductsState> emitter,
  ) async {
    emitter(ProductsLoading());
    bool noError = true;
    noError = Random().nextInt(100) > 5;
    if (noError) {
      var res = await productsRepository.getProductList(token: userRepository.token,productIds: event.productIds , skipCount: 0);
      emitter(ProductsUpdated(items: res));
      return res;
    } else {
      emitter(ProductsFailure(error: 'error loading products'));
      return null;
    }
  }
}
