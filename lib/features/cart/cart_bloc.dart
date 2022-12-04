import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/products/model/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddItem>(onItemAdded);
    on<RemoveItem>(onItemRemoved);
    on<ClearCart>(onClearCart);
  }

  void onItemAdded(
    AddItem event,
    Emitter<CartState> emit,
  ) {
    state.items.add(event.item);
    emit(CartUpdated(items: state.items));
  }

  void onItemRemoved(
    RemoveItem event,
    Emitter<CartState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(CartUpdated(items: state.items));
  }

  void onClearCart(
    ClearCart event,
    Emitter<CartState> emit,
  ) {
    emit(CartInitial());
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
