import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'repository.dart';

class PromosBloc extends Bloc<PromosEvent, PromosState> {
  PromoRepository repository = PromoRepository();
  PromosBloc() : super(PromosInitial()) {
    on<InitializePromos>(onInitPromosData);
  }

  Future<void> onInitPromosData(
    InitializePromos event,
    Emitter<PromosState> emit,
  ) async {
    emit(PromosLoading());
    var promotions = await repository.loadAllPromos();
    emit(PromosUpdated(promotions: promotions));
  }
}

/* ---  States   --- */
abstract class PromosState {
  final List<Promo> promotions = [];

  PromosState();
}

class PromosInitial extends PromosState {
  PromosInitial();
}

class PromosLoading extends PromosState {
  PromosLoading();
}

class PromosUpdated extends PromosState {
  PromosUpdated({required List<Promo> promotions}) {
    promotions.addAll(promotions);
  }
}

/* ---  Events   --- */

abstract class PromosEvent {
  const PromosEvent();
}

class InitializePromos extends PromosEvent {
  final List<Promo> promotions = [];
  InitializePromos();
}
