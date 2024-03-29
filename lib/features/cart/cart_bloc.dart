import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/cart/cart_repository.dart';

import '../catalog/products/model/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository repository = CartRepository();
  AuthenticationBloc authBloc;
  CartBloc({required this.authBloc}) : super(CartInitial()) {
    on<Authorized>(loadSavedCart);
    on<AddItem>(onItemAdded);
    on<RemoveItem>(onItemRemoved);
    on<ClearCart>(onClearCart);
  }

  Future<void> loadSavedCart(
    Authorized event,
    Emitter<CartState> emit,
  ) async {
    emit(CartInitial());
    var productList =
        await repository.getCartItemsInfo(productIds: event.itemIdList.toSet().toList(), token: event.token);
    for (var itemId in event.itemIdList) {
      state.items.add(productList.singleWhere((element) => element.id == itemId));
    }
    emit(CartUpdated(items: state.items));
  }

  void onItemAdded(
    AddItem event,
    Emitter<CartState> emit,
  ) {
    state.items.add(event.item);
    emit(CartUpdated(items: state.items));
    var authState = authBloc.state;
    if (authState is AuthenticationAuthenticated) {
      repository.updateCart(
        productIds: state.items.map((e) => e.id).toList(),
        token: authState.token,
        userId: authState.userData.id,
      );
    }
  }

  void onItemRemoved(
    RemoveItem event,
    Emitter<CartState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(CartUpdated(items: state.items));
    var authState = authBloc.state;
    if (authState is AuthenticationAuthenticated) {
      repository.updateCart(
        productIds: state.items.map((e) => e.id).toList(),
        token: authState.token,
        userId: authState.userData.id,
      );
    }
  }

  void onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) {
    emit(CartInitial());
    var authState = authBloc.state;
    if (authState is AuthenticationAuthenticated) {
      repository.updateCart(
        productIds: [],
        token: authState.token,
        userId: authState.userData.id,
      );
    }
  }
}

/* ---  States   --- */
abstract class CartState {
  final List<Product> items;

  double get totalPrice => items.fold(0, (previousValue, element) => previousValue + element.price);

  Map<Product, int> get itemsCounted {
    Map<Product, int> res = {for (var item in items.toSet().toList()) item: 0};
    res = res.map((key, value) => MapEntry(key, items.where((item) => item == key).length));
    return res;
  }

  CartState({required this.items});
}

class CartInitial extends CartState {
  CartInitial() : super(items: []);
}

class CartUpdated extends CartState {
  CartUpdated({required super.items});
}

/* ---  Events   --- */

abstract class CartEvent {
  const CartEvent();
}

class Authorized extends CartEvent {
  final String token;
  List<String> itemIdList;
  Authorized({required this.itemIdList, required this.token});
}

class AddItem extends CartEvent {
  Product item;
  AddItem({required this.item});
}

class RemoveItem extends CartEvent {
  Product item;
  RemoveItem({required this.item});
}

class ClearCart extends CartEvent {
  ClearCart();
}
