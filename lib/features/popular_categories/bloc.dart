import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/popular_categories/popular_categories.dart';

import '../authentication/user_repository.dart';
import '../catalog/categories/categories_repository.dart';

class PopularCategoriesBloc extends Bloc<PopularCategoriesEvent, PopularCategoriesState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  PopularCategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(PopularCategoriesInitial(categories: [])) {
    on<Authorized>(_loadCategories);
  }

  Future<void> _loadCategories(
    Authorized event,
    Emitter<PopularCategoriesState> emitter,
  ) async {
    emitter(PopularCategoriesLoading(categories: state.categories));
    var res = await categoriesRepository.getPopularCategories(token: userRepository.token);
    if (res != null) {
      emitter(PopularCategoriesLoaded(categories: res));
    } else {
      emitter(PopularCategoriesLoadFailure(error: 'error categories'));
    }
  }
}
