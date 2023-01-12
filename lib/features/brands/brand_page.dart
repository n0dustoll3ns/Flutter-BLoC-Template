import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

class BrandPageBloc extends Bloc<BrandPageBlocEvent, BrandPageBlocsState> {
  final ProductsRepository _productsRepository = ProductsRepository();
  final CategoriesRepository _categoriesRepository = CategoriesRepository();
  BrandPageBloc({required Brand brand}) : super(BrandPageBlocsInitial(brand: brand)) {
    on<BrandPageEntered>(onBrandPageEntered);
  }

  Future<void> onBrandPageEntered(
    BrandPageEntered event,
    Emitter<BrandPageBlocsState> emit,
  ) async {
    emit(BrandPageBlocsUpdated(brand: state.brand, items: state.items, categories: state.categories));
    var products = await _productsRepository.getProductsByBrand(brand: event.brand);
    var categories = await _categoriesRepository.getCategoriesOfListProducts(items: products);
    state.items.addAll(products);
    state.categories.addAll(categories);
    emit(BrandPageBlocsUpdated(brand: state.brand, items: state.items, categories: categories));
  }
}

/* ---  States   --- */
abstract class BrandPageBlocsState {
  final Brand brand;
  final List<Product> items;
  final List<Category> categories;
  BrandPageBlocsState({required this.brand, required this.items, required this.categories});
}

class BrandPageBlocsInitial extends BrandPageBlocsState {
  BrandPageBlocsInitial({required super.brand}) : super(items: [], categories: []);
}

class BrandPageBlocsLoading extends BrandPageBlocsState {
  BrandPageBlocsLoading({required super.brand, required super.items, required super.categories});
}

class BrandPageBlocsUpdated extends BrandPageBlocsState {
  BrandPageBlocsUpdated({required super.brand, required super.items, required super.categories});
}

/* ---  Events   --- */

abstract class BrandPageBlocEvent {
  const BrandPageBlocEvent();
}

class BrandPageEntered extends BrandPageBlocEvent {
  final Brand brand;
  BrandPageEntered({required this.brand});
}
