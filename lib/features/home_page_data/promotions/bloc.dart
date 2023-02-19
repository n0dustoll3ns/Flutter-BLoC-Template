import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/promo/model.dart';
import 'package:flutter_bloc_template/features/promo/repository.dart';

class MainPagePromotionsBloc extends Bloc<MainPagePromotionEvent, MainPagePromotionsState> {
  PromoRepository repository = PromoRepository();
  MainPagePromotionsBloc() : super(MainPagePromotionsInitial()) {
    on<AppStarted>(onAppStarted);
    on<LoadMoreButtonPressed>(onLoadMoreButtonPressed);
  }

  Future<void> onAppStarted(
    AppStarted event,
    Emitter<MainPagePromotionsState> emit,
  ) async {
    emit(MainPagePromotionsLoading(items: state.items));
    var items = await repository.loadMainPagePromos(1);
    emit(MainPagePromotionsUpdated(items: items));
  }

  Future<void> onLoadMoreButtonPressed(
    LoadMoreButtonPressed event,
    Emitter<MainPagePromotionsState> emit,
  ) async {
    emit(MainPagePromotionsLoading(items: state.items));
    var items = await repository.loadMainPagePromos(state.items.length ~/ 2 + 1);
    for (var element in items) {
      if (!state.items.map((e) => e.id).contains(element.id)) state.items.add(element);
    }
    emit(MainPagePromotionsUpdated(items: state.items));
  }
}

/* ---  States   --- */
abstract class MainPagePromotionsState {
  final List<Promo> items;

  MainPagePromotionsState({required this.items});
}

class MainPagePromotionsInitial extends MainPagePromotionsState {
  MainPagePromotionsInitial() : super(items: []);
}

class MainPagePromotionsLoading extends MainPagePromotionsState {
  MainPagePromotionsLoading({required super.items});
}

class MainPagePromotionsUpdated extends MainPagePromotionsState {
  MainPagePromotionsUpdated({required super.items});
}

/* ---  Events   --- */

abstract class MainPagePromotionEvent {
  const MainPagePromotionEvent();
}

class AppStarted extends MainPagePromotionEvent {
  AppStarted();
}

class LoadMoreButtonPressed extends MainPagePromotionEvent {
  LoadMoreButtonPressed();
}
