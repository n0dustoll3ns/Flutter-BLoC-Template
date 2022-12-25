import 'package:flutter_bloc/flutter_bloc.dart';

import '../../authentication/user_repository.dart';
import 'states.dart';
import 'categories_repository.dart';

class CategoriesBloc extends Bloc<CatalogEvent, CatalogPageState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CatalogPageInitial(categories: [])) {
    on<CatalogPageEnter>(_loadCategories);
  }

  Future<void> _loadCategories(CatalogPageEnter event, Emitter<CatalogPageState> emitter) async {
    emitter(CatalogPageLoading(categories: state.categories));
    var res = await categoriesRepository.getInheritedCategories(
        token: userRepository.token, categoryId: event.category?.id);
    if (res != null) {
      emitter(CatalogPageLoaded(categories: res));
    } else {
      emitter(CatalogPageLoadFailure(error: 'error categories'));
    }
  }
}
