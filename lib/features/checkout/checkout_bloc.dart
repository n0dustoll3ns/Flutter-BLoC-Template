import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/order/model.dart';
import 'package:flutter_bloc_template/features/payment/methods/model.dart';

import '../order/orders_bloc.dart';
import '../reciever/model.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  final OrdersBloc ordersBloc;
  CheckoutBloc({required this.ordersBloc}) : super(CheckoutInitial()) {
    on<CreateOrder>(onCreateOrder);
    on<SetReciever>(onSetRecieverRemoved);
    on<SetAdress>(onSetAdressCheckout);
    on<SetPaymentMethod>(onSetPaymentMethod);
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
    emit(state.copyWith(newReciever: event.reciever));
  }

  void onSetAdressCheckout(
    SetAdress event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(newAdress: event.adress));
  }

  void onSetPaymentMethod(
    SetPaymentMethod event,
    Emitter<CheckoutState> emit,
  ) {
    emit(state.copyWith(newPaymentMethod: event.paymentMethod));
  }
}

/* ---  States   --- */
abstract class CheckoutState {
  Reciever? reciever;
  Adress? adress;
  PaymentMethod? paymentMethod;
  int get stageIndex {
    if (reciever == null) {
      return 0;
    } else if (adress == null) {
      return 1;
    } else if (paymentMethod == null) {
      return 2;
    } else if (reciever != null && adress != null && paymentMethod != null) {
      return 3;
    }
    return 0;
  }

  CheckoutUpdated copyWith({Reciever? newReciever, Adress? newAdress, PaymentMethod? newPaymentMethod}) {
    return CheckoutUpdated(
      reciever: newReciever ?? reciever,
      adress: newAdress ?? adress,
      paymentMethod: newPaymentMethod ?? paymentMethod,
    );
  }

  CheckoutState({
    required this.reciever,
    required this.adress,
    required this.paymentMethod,
  });
}

class CheckoutInitial extends CheckoutState {
  CheckoutInitial({super.reciever, super.adress, super.paymentMethod});
}

class CheckoutUpdated extends CheckoutState {
  CheckoutUpdated({required super.reciever, required super.adress, required super.paymentMethod});
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

class SetPaymentMethod extends CheckoutEvent {
  final PaymentMethod paymentMethod;
  SetPaymentMethod({required this.paymentMethod});
}
