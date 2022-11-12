import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

import '../categories/categories.dart';
import 'model/product.dart';
import 'products.dart';

class ProductsBloc extends Bloc<CatalogEvent, ProductsState> {
  final ProductsRepository productsRepository;
  final UserRepository userRepository;
  ProductsBloc({
    required this.userRepository,
    required this.productsRepository,
  }) : super(ProductsInitial()) {
    on<CategoryPageEnter>(_refreshProductsList);
    on<ProductsRequest>(_loadMoreProducts);
  }

  Future<void> _refreshProductsList(
    CategoryPageEnter event,
    Emitter<ProductsState> emitter,
  ) async {
    emitter(ProductsLoading());
    bool noError = true;
    var res = await productsRepository.getProductList(token: userRepository.token, skipCount: 0);
    if (noError) {
      emitter(ProductsUpdated(products: res));
    } else {
      emitter(ProductsFailure(error: 'error loading products'));
    }
  }

  Future<void> _loadMoreProducts(
    ProductsRequest event,
    Emitter<ProductsState> emitter,
  ) async {
    emitter(ProductsLoading());
    bool noError = true;
    if (noError) {
      List<Product> delta = [];
      if (state is ProductsUpdated) {
        delta.addAll((state as ProductsUpdated).products);
      }
      var res = await productsRepository.getProductList(token: userRepository.token, skipCount: delta.length);
      emitter(ProductsUpdated(products: res + delta));
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
