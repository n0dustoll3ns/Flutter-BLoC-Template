import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/model.dart';
import 'package:flutter_bloc_template/features/order/model.dart';

import '../catalog/products/model/product.dart';
import '../reciever/model.dart';

class OrdersBloc extends Bloc<OrderEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitial()) {
    on<AddOrder>(onOrderAdded);
    on<RemoveOrder>(onOrderRemoved);
    on<ClearOrders>(onClearOrders);
  }

  List<Product> get orderedItems {
    List<Product> list = [];
    for (var order in state.items) {
      list.addAll(order.items);
    }
    return list;
  }

  void onOrderAdded(
    AddOrder event,
    Emitter<OrdersState> emit,
  ) {
    state.items.add(event.item);
    emit(OrdersUpdated(items: state.items));
  }

  void onOrderRemoved(
    RemoveOrder event,
    Emitter<OrdersState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(OrdersUpdated(items: state.items));
  }

  void onClearOrders(
    ClearOrders event,
    Emitter<OrdersState> emit,
  ) {
    emit(OrdersInitial());
  }
}

/* ---  States   --- */
abstract class OrdersState {
  final List<Order> items;
  final Reciever? selectedReciever;
  final Adress? selectedAdress;
  OrdersState({
    required this.items,
    this.selectedReciever,
    this.selectedAdress,
  });
}

class OrdersInitial extends OrdersState {
  OrdersInitial() : super(items: []);
}

class OrdersUpdated extends OrdersState {
  OrdersUpdated({required super.items});
}

/* ---  Events   --- */

abstract class OrderEvent {
  const OrderEvent();
}

class AddOrder extends OrderEvent {
  Order item;
  AddOrder({required this.item});
}

class RemoveOrder extends OrderEvent {
  Order item;
  RemoveOrder({required this.item});
}

class ClearOrders extends OrderEvent {
  ClearOrders();
}
