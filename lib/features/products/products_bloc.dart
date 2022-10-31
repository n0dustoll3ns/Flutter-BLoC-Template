import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/products/model/product.dart';
import 'package:flutter_bloc_template/features/products/products_repository.dart';

import 'products.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;
  final UserRepository userRepository;
  ProductsBloc({
    required this.userRepository,
    required this.productsRepository,
  }) : super(ProductsInitial()) {
    on<ProductsPageEnter>(_productsPageEnter);
    on<ProductsRequest>(_requstProducts);
  }

  Future<void> _productsPageEnter(
    ProductsPageEnter event,
    Emitter<ProductsState> emitter,
  ) async {
    emitter(ProductsLoading());
    bool noError = true;
    await productsRepository.getProductList(token: userRepository.token, skipCount: 0);
    if (noError) {
      emitter(ProductsUpdated());
    } else {
      emitter(ProductsFailure(error: 'error loading products'));
    }
  }

  Future<void> _requstProducts(
    ProductsRequest event,
    Emitter<ProductsState> emitter,
  ) async {
    emitter(ProductsLoading());
    bool noError = true;
    await productsRepository.getProductList(
        token: userRepository.token, skipCount: productsRepository.products.length);
    if (noError) {
      emitter(ProductsUpdated());
    } else {
      emitter(ProductsFailure(error: 'error loading products'));
    }
  }

  // void _logOut(
  //   LoggedOut event,
  //   Emitter<AuthenticationState> emitter,
  // ) async {
  //   emitter(AuthenticationLoading());
  //   await userRepository.deleteToken();
  //   emitter(AuthenticationUnauthenticated());
  // }
}
