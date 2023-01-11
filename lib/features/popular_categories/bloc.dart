import 'package:flutter_bloc/flutter_bloc.dart';

import '../catalog/categories/categories_repository.dart';
import '../catalog/categories/model/model.dart';

class PopularCategoriesBloc extends Bloc<PopularCategoriesEvent, PopularCategoriesState> {
  final CategoriesRepository repository = CategoriesRepository();
  PopularCategoriesBloc() : super(PopularCategoriesInitial(categories: [])) {
    on<AppStarted>(_loadCategories);
  }

  Future<void> _loadCategories(
    AppStarted event,
    Emitter<PopularCategoriesState> emitter,
  ) async {
    emitter(PopularCategoriesLoading(categories: state.categories));
    var res = await repository.getPopularCategories();
    if (res != null) {
      emitter(PopularCategoriesLoaded(categories: res));
    } else {
      emitter(PopularCategoriesLoadFailure(error: 'error categories'));
    }
  }
}

/* ---  States   --- */

abstract class PopularCategoriesState {
  final List<Category> categories;
  PopularCategoriesState({required this.categories});
}

class PopularCategoriesInitial extends PopularCategoriesState {
  PopularCategoriesInitial({required super.categories});
}

class PopularCategoriesLoading extends PopularCategoriesState {
  PopularCategoriesLoading({required super.categories});
}

class PopularCategoriesLoadFailure extends PopularCategoriesState {
  final String error;

  PopularCategoriesLoadFailure({
    required this.error,
  }) : super(categories: []);

  @override
  String toString() => 'CategoryFailure { error: $error }';
}

class PopularCategoriesLoaded extends PopularCategoriesState {
  PopularCategoriesLoaded({required super.categories});
}

/* ---  Events   --- */

abstract class PopularCategoriesEvent {
  const PopularCategoriesEvent();
}

class AppStarted extends PopularCategoriesEvent {
  const AppStarted();
}
