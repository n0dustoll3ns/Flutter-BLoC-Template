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
  OrdersBloc({required this.authenticationBloc})
      : super(const OrdersInitial()) {
    on<AddOrder>(onOrderAdded);
    on<Authorized>(onAuthorized);
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
        emit(const OrderRequestFailed(items: [], message: 'Order creating has failed.'));
      }
    }
  }

  Future<void> onAuthorized(
    Authorized event,
    Emitter<OrdersState> emit,
  ) async {
    emit(OrderLoading(items: state.items));
    var res = await repository.loadUserOrderList(
        token: event.token);
    if (res != null) {
      emit(OrdersUpdated(items: res));
    } else {
      emit(const OrderRequestFailed(items: [], message: 'Order loading has failed.'));
    }
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

class OrderRequestFailed extends OrdersState {
  final String message;
  const OrderRequestFailed({required super.items, required this.message});
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

class Authorized extends OrderEvent {
  final String token;
  const Authorized({required this.token});
}
