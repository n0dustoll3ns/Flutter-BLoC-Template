import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/model.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/order/model.dart';
import 'package:flutter_bloc_template/features/order/order_repository.dart';

import '../catalog/products/model/product.dart';
import '../reciever/model.dart';

class OrdersBloc extends Bloc<OrderEvent, OrdersState> {
  OrderRepository repository = OrderRepository();
  AuthenticationBloc authenticationBloc;
  OrdersBloc({required this.authenticationBloc}) : super(const OrdersInitial()) {
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

  Future<void> onOrderAdded(
    AddOrder event,
    Emitter<OrdersState> emit,
  ) async {
    var authState = authenticationBloc.state;
    if (authState is AuthenticationAuthenticated) {
      emit(OrderLoading(items: state.items));
      var res = await repository.createOrder(
          order: event.item, token: authState.token, userId: authState.userData.id);
      if (res != null) {
        List<Order> list = List.from(state.items);
        list.add(event.item);
        emit(OrdersUpdated(items: list));
      } else {
        emit(const OrderCreationFailed(items: [], message: 'Order creating has failed.'));
      }
    }
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
    emit(const OrdersInitial());
  }
}

/* ---  States   --- */
abstract class OrdersState {
  final List<Order> items;
  final Reciever? selectedReciever;
  final Adress? selectedAdress;
  const OrdersState({
    required this.items,
    this.selectedReciever,
    this.selectedAdress,
  });
}

class OrdersInitial extends OrdersState {
  const OrdersInitial() : super(items: const []);
}

class OrderLoading extends OrdersState {
  const OrderLoading({required super.items});
}

class OrderCreationFailed extends OrdersState {
  final String message;
  const OrderCreationFailed({required super.items, required this.message});
}

class OrdersUpdated extends OrdersState {
  const OrdersUpdated({required super.items});
}

/* ---  Events   --- */

abstract class OrderEvent {
  const OrderEvent();
}

class AddOrder extends OrderEvent {
  final Order item;
  const AddOrder({required this.item});
}

class RemoveOrder extends OrderEvent {
  final Order item;
  const RemoveOrder({required this.item});
}

class ClearOrders extends OrderEvent {
  const ClearOrders();
}
