import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';

import '../features/authentication/auth_bloc.dart';
import '../features/authentication/states.dart';
import '../features/catalog/categories/categories_bloc.dart';
import '../features/catalog/categories/categories_repository.dart';
import '../features/catalog/products/products_bloc.dart';
import '../features/login/login_bloc.dart';
import '../ui/screens/login_screen/login_screen.dart';
import '../ui/screens/splash_screen.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var authenticationBloc = AuthenticationBloc();
    authenticationBloc.add(AppStarted());
    var categoriesBloc = CategoriesBloc(
        userRepository: authenticationBloc.userRepository, categoriesRepository: CategoriesRepository());
    var userBloc = UserBloc();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: (context) => authenticationBloc),
        BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
                  userRepository: authenticationBloc.userRepository,
                )),
        BlocProvider<CategoriesBloc>(create: ((context) => categoriesBloc)),
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                  userRepository: authenticationBloc.userRepository,
                  authenticationBloc: authenticationBloc,
                  userBloc: userBloc,
                )),
        BlocProvider(create: (_) => userBloc),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => FavouriteBloc()),
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
