import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/authentication/auth_bloc.dart';
import '../features/authentication/authentication.dart';
import '../features/authentication/user_repository.dart';
import '../features/catalog/categories/categories.dart';
import '../features/catalog/categories/categories_bloc.dart';
import '../features/catalog/categories/categories_repository.dart';
import '../features/catalog/products/products_bloc.dart';
import '../features/catalog/products/products_repository.dart';
import '../features/login/login_bloc.dart';
import '../ui/screens/login_screen/login_screen.dart';
import '../ui/screens/splash_screen.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc;
    CategoriesBloc categoriesBloc;
    bool dialogIsShown = false;

    authenticationBloc = AuthenticationBloc(userRepository: UserRepository());
    authenticationBloc.add(AppStarted());
    categoriesBloc = CategoriesBloc(
        userRepository: authenticationBloc.userRepository, categoriesRepository: CategoriesRepository())
      ..add(const ApplicationStarted());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: ((context) => authenticationBloc)),
        BlocProvider<ProductsBloc>(
            create: ((context) => ProductsBloc(
                userRepository: authenticationBloc.userRepository,
                productsRepository: ProductsRepository()))),
        BlocProvider<CategoriesBloc>(create: ((context) => categoriesBloc)),
        BlocProvider<LoginBloc>(
            create: ((context) => LoginBloc(
                  userRepository: authenticationBloc.userRepository,
                  authenticationBloc: authenticationBloc,
                ))),
      ],
      child: MaterialApp(
        theme: theme,
        routes: Routes.routes,
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return const SplashScreen();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
