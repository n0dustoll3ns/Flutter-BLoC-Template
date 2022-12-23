import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';


class FavouriteCategoriesBloc extends Bloc<FavouriteCategoriesEvent, FavouriteCategoriesState> {
  FavouriteCategoriesBloc() : super(FavouriteCategoriesInitial()) {
    on<LikeCategory>(onItemAdded);
    on<DislikeCategory>(onItemRemoved);
    on<DislikeAllCategories>(onClearFavouriteCategories);
  }

  void onItemAdded(
    LikeCategory event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    var list = state.items..add(event.item);
    emit(FavouriteCategoriesUpdated(items: list));
  }

  void onItemRemoved(
    DislikeCategory event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    state.items.removeWhere(((element) => element == event.item));
    emit(FavouriteCategoriesUpdated(items: state.items));
  }

  void onClearFavouriteCategories(
    DislikeAllCategories event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    emit(FavouriteCategoriesInitial());
  }
}

/* ---  States   --- */
abstract class FavouriteCategoriesState {
  final Set<Category> items;

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

class LikeCategory extends FavouriteCategoriesEvent {
  Category item;
  LikeCategory({required this.item});
}

class DislikeCategory extends FavouriteCategoriesEvent {
  Category item;
  DislikeCategory({required this.item});
}

class DislikeAllCategories extends FavouriteCategoriesEvent {
  DislikeAllCategories();
}
