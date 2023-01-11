import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/popular_categories/popular_categories.dart';

import '../catalog/categories/categories_repository.dart';

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
