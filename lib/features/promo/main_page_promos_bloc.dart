import 'package:flutter_bloc/flutter_bloc.dart';

import 'model.dart';
import 'repository.dart';

class PromosBloc extends Bloc<PromosEvent, PromosState> {
  PromoRepository repository = PromoRepository();
  PromosBloc() : super(PromosInitial()) {
    on<InitializePromos>(loadPromosData);
  }

  Future<void> loadPromosData(
    InitializePromos event,
    Emitter<PromosState> emit,
  ) async {
    emit(PromosLoading(promotions: state.promotions));
    var promotions = await repository.loadAllPromos();
    emit(PromosUpdated(promotions: promotions));
  }
}

/* ---  States   --- */
abstract class PromosState {
  final List<Promo> promotions;
  PromosState({required this.promotions});
}

class PromosInitial extends PromosState {
  PromosInitial() : super(promotions: []);
}

class PromosLoading extends PromosState {
  PromosLoading({required super.promotions});
}

class PromosUpdated extends PromosState {
  PromosUpdated({required super.promotions});
}

/* ---  Events   --- */

abstract class PromosEvent {
  const PromosEvent();
}

class InitializePromos extends PromosEvent {
  final List<Promo> promotions = [];
  InitializePromos();
}
