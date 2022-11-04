import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories.dart';

class CategoriesBloc extends Bloc<CategoryEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CategoriesInitial()) {
    on<ApplicationEntered>(_categoriesLoad);
    on<CategoryChange>(_setCategory);
  }

  Future<void> _categoriesLoad(
    ApplicationEntered event,
    Emitter<CategoriesState> emitter,
  ) async {
    emitter(CategoriesLoading());
    var res = await categoriesRepository.getCategories(token: userRepository.token);
    if (res != null) {
      emitter(CategoriesLoaded(categories: res));
    } else {
      emitter(const CategoriesLoadFailure(error: 'error categories'));
    }
  }

  void _setCategory(
    CategoryChange event,
    Emitter<CategoriesState> emitter,
  ) {
    if (state is CategoriesLoaded) {
      emitter((state as CategoriesLoaded).setCategory(event.category));
    }
  }
}
