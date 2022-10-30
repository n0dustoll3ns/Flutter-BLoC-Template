import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
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
    on<ProductsRequest>(_tryLogin);
  }

  Future<void> _productsPageEnter(
    ProductsPageEnter event,
    Emitter<ProductsState> emitter,
  ) async {
    await productsRepository.getProductList(
        token: userRepository.token, skipCount: productsRepository.products.length);
    if (hasToken) {
      emitter(Prod());
    } else {
      emitter(AuthenticationUnauthenticated());
    }
  }

  void _tryLogin(
    LoggedIn event,
    Emitter<AuthenticationState> emitter,
  ) {
    emitter(AuthenticationLoading());
    userRepository.persistToken(event.token);
    emitter(AuthenticationAuthenticated());
  }

  void _logOut(
    LoggedOut event,
    Emitter<AuthenticationState> emitter,
  ) async {
    emitter(AuthenticationLoading());
    await userRepository.deleteToken();
    emitter(AuthenticationUnauthenticated());
  }
}
