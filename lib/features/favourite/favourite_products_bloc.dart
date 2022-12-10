import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/products/model/product.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<LikeItem>(onItemAdded);
    on<DislikeItem>(onItemRemoved);
    on<DislikeAll>(onClearFavourite);
  }

  void onItemAdded(
    LikeItem event,
    Emitter<FavouriteState> emit,
  ) {
    var list = state.items..add(event.item);
    emit(FavouriteUpdated(items: list));
  }

  void onItemRemoved(
    DislikeItem event,
    Emitter<FavouriteState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(FavouriteUpdated(items: state.items));
  }

  void onClearFavourite(
    DislikeAll event,
    Emitter<FavouriteState> emit,
  ) {
    emit(FavouriteInitial());
  }
}

/* ---  States   --- */
abstract class FavouriteState {
  final Set<Product> items;

  FavouriteState({required this.items});
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial() : super(items: {});
}

class FavouriteUpdated extends FavouriteState {
  FavouriteUpdated({required super.items});
}

/* ---  Events   --- */

abstract class FavouriteEvent {
  const FavouriteEvent();
}

class LikeItem extends FavouriteEvent {
  Product item;
  LikeItem({required this.item});
}

class DislikeItem extends FavouriteEvent {
  Product item;
  DislikeItem({required this.item});
}

class DislikeAll extends FavouriteEvent {
  DislikeAll();
}
