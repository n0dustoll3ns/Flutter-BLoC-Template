import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/user_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_repository.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

class CategoriesBloc extends Bloc<CategoryEvent, CategoriesState> {
  final CategoriesRepository categoriesRepository;
  final UserRepository userRepository;
  CategoriesBloc({
    required this.userRepository,
    required this.categoriesRepository,
  }) : super(CategoriesInitial()) {
    on<ApplicationEnter>(_categoriesLoad);
    // on<CategoryRequest>(_categoriesLoad);
  }

  Future<void> _categoriesLoad(
    ApplicationEnter event,
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

  // void _logOut(
  //   LoggedOut event,
  //   Emitter<AuthenticationState> emitter,
  // ) async {
  //   emitter(AuthenticationLoading());
  //   await userRepository.deleteToken();
  //   emitter(AuthenticationUnauthenticated());
  // }
}
