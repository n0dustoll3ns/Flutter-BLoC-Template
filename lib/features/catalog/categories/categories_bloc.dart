import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

import '../../authentication/user_repository.dart';
import 'states.dart';
import 'categories_repository.dart';

class CategoriesBloc extends Bloc<CatalogEvent, CatalogState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CategoryInitial(
            category: Category(name: 'Root Category', description: 'Root category Description'))) {
    on<CategoryPageEnter>(_loadInheritedCategories);
  }

  Future<void> _loadInheritedCategories(
    CategoryPageEnter event,
    Emitter<CatalogState> emitter,
  ) async {
    emitter(CategoryLoading(category: state.category));
    var newCategory = event.category;
    var res = await categoriesRepository.getInheritedCategories(
        token: userRepository.token, category: event.category);
    newCategory.inheritedCategories = res;
    if (res != null) {
      emitter(CategoryLoaded(category: newCategory));
    } else {
      emitter(CategoryLoadFailure(error: 'error categories', category: Category.defaulta()));
    }
  }
}
