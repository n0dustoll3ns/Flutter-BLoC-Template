import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories.dart';

class CategoriesBloc extends Bloc<CatalogEvent, CatalogState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CategoryInitial()) {
    on<ApplicationStarted>(_loadRootCategory);
    on<CategoryPageEnter>(_loadInheritedCategories);
  }

  Future<void> _loadRootCategory(
    ApplicationStarted event,
    Emitter<CatalogState> emitter,
  ) async {
    bool noError = true;
    emitter(CategoryLoading());
    var res = await categoriesRepository.getRootCategory(token: userRepository.token);
    if (res != null) {
      emitter(CategoryLoaded(category: res));
    } else {
      emitter(CategoryLoadFailure(
        error: 'error categories',
      ));
    }
  }

  Future<void> _loadInheritedCategories(
    CategoryPageEnter event,
    Emitter<CatalogState> emitter,
  ) async {
    emitter(CategoryLoading());
    var newCategory = event.category;
    var res = await categoriesRepository.getInheritedCategories(
        token: userRepository.token, category: event.category);
    newCategory.inheritedCategories = res;
    if (res != null) {
      emitter(CategoryLoaded(category: newCategory));
    } else {
      emitter(CategoryLoadFailure(
        error: 'error categories',
      ));
    }
  }
}
