import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/user_repository.dart';
import 'states.dart';
import 'categories_repository.dart';

class CategoriesBloc extends Bloc<CatalogEvent, CatalogState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CategoryInitial(categories: [])) {
    on<CategoryPageEnter>(_loadCategories);
  }

  Future<void> _loadCategories(
    CategoryPageEnter event,
    Emitter<CatalogState> emitter,
  ) async {
    emitter(CategoryLoading(categories: state.categories));
    var res = await categoriesRepository.getInheritedCategories(
        token: userRepository.token, categoryId: event.category?.id);
    if (res != null) {
      emitter(CategoryLoaded(categories: res));
    } else {
      emitter(CategoryLoadFailure(error: 'error categories'));
    }
  }

}
