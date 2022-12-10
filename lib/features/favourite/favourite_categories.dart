import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/products/model/product.dart';

class FavouriteCategoriesBloc extends Bloc<FavouriteCategoriesEvent, FavouriteCategoriesState> {
  FavouriteCategoriesBloc() : super(FavouriteCategoriesInitial()) {
    on<LikeItem>(onItemAdded);
    on<DislikeItem>(onItemRemoved);
    on<DislikeAll>(onClearFavouriteCategories);
  }

  void onItemAdded(
    LikeItem event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    var list = state.items..add(event.item);
    emit(FavouriteCategoriesUpdated(items: list));
  }

  void onItemRemoved(
    DislikeItem event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(FavouriteCategoriesUpdated(items: state.items));
  }

  void onClearFavouriteCategories(
    DislikeAll event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    emit(FavouriteCategoriesInitial());
  }
}

/* ---  States   --- */
abstract class FavouriteCategoriesState {
  final Set<Product> items;

  FavouriteCategoriesState({required this.items});
}

class FavouriteCategoriesInitial extends FavouriteCategoriesState {
  FavouriteCategoriesInitial() : super(items: {});
}

class FavouriteCategoriesUpdated extends FavouriteCategoriesState {
  FavouriteCategoriesUpdated({required super.items});
}

/* ---  Events   --- */

abstract class FavouriteCategoriesEvent {
  const FavouriteCategoriesEvent();
}

class LikeItem extends FavouriteCategoriesEvent {
  Product item;
  LikeItem({required this.item});
}

class DislikeItem extends FavouriteCategoriesEvent {
  Product item;
  DislikeItem({required this.item});
}

class DislikeAll extends FavouriteCategoriesEvent {
  DislikeAll();
}
