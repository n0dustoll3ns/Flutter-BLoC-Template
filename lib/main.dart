import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';

import 'app/routes/routes.dart';
import 'app/theme/theme.dart';
import 'features/authentication/auth_bloc.dart';
import 'features/authentication/user_repository.dart';
import 'features/login/login_bloc.dart';
import 'ui/screens/login_screen/login_screen.dart';
import 'ui/screens/main_screen/main_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/widgets/loading_indicator.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late AuthenticationBloc authenticationBloc;
  bool dialogIsShown = false;
  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: UserRepository());
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(create: ((context) => authenticationBloc)),
        BlocProvider<ProductsBloc>(
            create: ((context) => ProductsBloc(
                userRepository: authenticationBloc.userRepository,
                productsRepository: ProductsRepository()))),
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
              return const SplashPage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
