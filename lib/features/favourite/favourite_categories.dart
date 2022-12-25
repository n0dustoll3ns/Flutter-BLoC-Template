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
    var list = state.categories..add(event.item);
    emit(FavouriteCategoriesUpdated(categories: list));
  }

  void onItemRemoved(
    DislikeCategory event,
    Emitter<FavouriteCategoriesState> emit,
  ) {
    state.categories.removeWhere(((element) => element == event.item));
    emit(FavouriteCategoriesUpdated(categories: state.categories));
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
  final Set<Category> categories;

  FavouriteCategoriesState({required this.categories});
}

class FavouriteCategoriesInitial extends FavouriteCategoriesState {
  FavouriteCategoriesInitial() : super(categories: {});
}

class FavouriteCategoriesUpdated extends FavouriteCategoriesState {
  FavouriteCategoriesUpdated({required super.categories});
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
