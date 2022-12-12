import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/order/model.dart';

import '../order/orders_bloc.dart';
import '../reciever/model.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrdersBloc ordersBloc;
  CheckoutBloc({required this.ordersBloc}) : super(CheckoutInitial()) {
    on<CreateOrder>(onCreateOrder);
    on<SetReciever>(onSetRecieverRemoved);
    on<SetAdress>(onSetAdressCheckout);
  }

  void onCreateOrder(
    CreateOrder event,
    Emitter<CheckoutState> emit,
  ) {
    ordersBloc
        .add(AddOrder(item: Order(reciever: state.reciever!, adress: state.adress!, items: event.items)));
  }

  void onSetRecieverRemoved(
    SetReciever event,
    Emitter<CheckoutState> emit,
  ) {
    state.reciever = event.reciever;
    emit(CheckoutUpdated(
      reciever: state.reciever,
      adress: state.adress,
    ));
  }

  void onSetAdressCheckout(
    SetAdress event,
    Emitter<CheckoutState> emit,
  ) {
    state.adress = event.adress;
    emit(CheckoutUpdated(
      reciever: state.reciever,
      adress: state.adress,
    ));
  }
}

/* ---  States   --- */
abstract class CheckoutState {
  Reciever? reciever;
  Adress? adress;
  int get stageIndex {
    if (reciever == null && adress == null) {
      return 0;
    } else if (reciever != null && adress == null) {
      return 1;
    } else if (reciever != null && adress != null) {
      return 2;
    }
    return 0;
  }

  CheckoutState({
    required this.reciever,
    required this.adress,
  });
}

class CheckoutInitial extends CheckoutState {
  CheckoutInitial({super.reciever, super.adress});
}

class CheckoutUpdated extends CheckoutState {
  CheckoutUpdated({required super.reciever, required super.adress});
}

/* ---  Events   --- */

abstract class CheckoutEvent {
  const CheckoutEvent();
}

class CreateOrder extends CheckoutEvent {
  List<Product> items;
  CreateOrder({required this.items});
}

class SetAdress extends CheckoutEvent {
  final Adress adress;
  SetAdress({required this.adress});
}

class SetReciever extends CheckoutEvent {
  final Reciever reciever;
  SetReciever({required this.reciever});
}
