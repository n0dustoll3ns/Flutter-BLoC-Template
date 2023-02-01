import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/repository.dart';

import 'model.dart';

class PaymentMethodsBloc extends Bloc<PaymentMethodEvent, PaymentMethodsState> {
  PaymentMethodsRepository repository = PaymentMethodsRepository();
  PaymentMethodsBloc() : super(PaymentMethodsInitial()) {
    on<LoadPaymentMethods>(onPaymentMethodLoad);
  }

  Future<void> onPaymentMethodLoad(
    LoadPaymentMethods event,
    Emitter<PaymentMethodsState> emit,
  ) async {
    emit(PaymentMethodsLoading());
    var methods = await repository.loadPaymentMethods();
    emit(PaymentMethodsUpdated(items: methods));
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
