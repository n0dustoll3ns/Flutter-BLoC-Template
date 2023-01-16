import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

import '../../authentication/user_repository.dart';
import 'states.dart';
import 'categories_repository.dart';

class CatalogPageBloc extends Bloc<CatalogEvent, CatalogPageState> {
  final CategoriesRepository categoriesRepository;
  final ProductsRepository productsRepository;
  final UserRepository userRepository;
  CatalogPageBloc({
    required this.userRepository,
    required this.categoriesRepository,
    required this.productsRepository,
  }) : super(CatalogPageInitial(categories: [], items: [])) {
    on<CatalogPageEnter>(_loadPageElements);
  }

  Future<void> _loadPageElements(CatalogPageEnter event, Emitter<CatalogPageState> emitter) async {
    emitter(CatalogPageLoading(categories: state.categories, items: state.items));
    var inheritedCategories =
        await categoriesRepository.getInheritedCategories(parentCategoryId: event.category?.id);
    if (inheritedCategories != null) {
      emitter(CatalogPageLoaded(categories: inheritedCategories, items: state.items));
    } else {
      emitter(CatalogPageLoadFailure(error: 'error categories'));
    }
  }
}
