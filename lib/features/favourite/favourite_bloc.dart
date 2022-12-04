import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/products/model/product.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    on<AddItem>(onItemAdded);
    on<RemoveItem>(onItemRemoved);
    on<ClearFavourite>(onClearFavourite);
  }

  void onItemAdded(
    AddItem event,
    Emitter<FavouriteState> emit,
  ) {
    state.items.add(event.item);
    emit(FavouriteUpdated(items: state.items));
  }

  void onItemRemoved(
    RemoveItem event,
    Emitter<FavouriteState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(FavouriteUpdated(items: state.items));
  }

  void onClearFavourite(
    ClearFavourite event,
    Emitter<FavouriteState> emit,
  ) {
    emit(FavouriteInitial());
  }
}

/* ---  States   --- */
abstract class FavouriteState {
  final List<Product> items;

  FavouriteState({required this.items});
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial() : super(items: []);
}

class FavouriteUpdated extends FavouriteState {
  FavouriteUpdated({required super.items});
}

/* ---  Events   --- */

abstract class FavouriteEvent {
  const FavouriteEvent();
}

class AddItem extends FavouriteEvent {
  Product item;
  AddItem({required this.item});
}

class RemoveItem extends FavouriteEvent {
  Product item;
  RemoveItem({required this.item});
}

class ClearFavourite extends FavouriteEvent {
  ClearFavourite();
}
