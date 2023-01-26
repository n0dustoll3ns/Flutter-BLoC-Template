import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'model.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodEvent, PaymentMethodsState> {
  PaymentMethodsBloc() : super(PaymentMethodsInitial()) {
    on<LoadPaymentMethods>(onPaymentMethodLoad);
  }

  void onPaymentMethodLoad(
    LoadPaymentMethods event,
    Emitter<PaymentMethodsState> emit,
  ) async {
    emit(PaymentMethodsLoading());
    await Future.delayed(const Duration(milliseconds: 1599));
    emit(PaymentMethodsUpdated(items: [
      PaymentMethod(
          id: 1, icon: Icons.credit_card, name: 'Credit card', description: lorem(paragraphs: 2, words: 75)),
      PaymentMethod(id: 2, icon: Icons.money, name: 'Cash', description: lorem(paragraphs: 2, words: 75)),
      PaymentMethod(
          id: 3,
          icon: Icons.book_online_rounded,
          name: 'Online',
          description: lorem(paragraphs: 2, words: 75)),
    ]));
  }
}

/* ---  States   --- */
abstract class PaymentMethodsState {
  final List<PaymentMethod> items;

  PaymentMethodsState({required this.items});
}

class PaymentMethodsInitial extends PaymentMethodsState {
  PaymentMethodsInitial() : super(items: []);
}

class PaymentMethodsLoading extends PaymentMethodsState {
  PaymentMethodsLoading() : super(items: []);
}

class PaymentMethodsUpdated extends PaymentMethodsState {
  PaymentMethodsUpdated({required super.items});
}

/* ---  Events   --- */

abstract class PaymentMethodEvent {
  const PaymentMethodEvent();
}

class LoadPaymentMethods extends PaymentMethodEvent {
  LoadPaymentMethods();
}
