import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/adresses_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_categories.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/features/order/orders_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/payment_methods.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';
import 'package:flutter_bloc_template/features/reviews/reviews_bloc.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';

import '../features/authentication/auth_bloc.dart';
import '../features/authentication/states.dart';
import '../features/catalog/categories/categories_bloc.dart';
import '../features/catalog/categories/categories_repository.dart';
import '../features/catalog/products/products_bloc.dart';
import '../ui/screens/error/error_screen.dart';
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
        BlocProvider(create: (_) => userBloc),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(create: (_) => FavouriteBloc()),
        BlocProvider(create: (_) => FavouriteCategoriesBloc()),
        BlocProvider(create: (_) => RecieversBloc(userRepository: authenticationBloc.userRepository)),
        BlocProvider(create: (_) => AdressesBloc(userRepository: authenticationBloc.userRepository)),
        BlocProvider(create: (_) => OrdersBloc()),
        BlocProvider(create: (_) => PaymentMethodsBloc()),
        BlocProvider(create: (_) => ReviewsBloc()),
        BlocProvider(create: (context) => CheckoutBloc(ordersBloc: context.read<OrdersBloc>())),
      ],
      child: MaterialApp(
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomError(errorDetails: errorDetails);
          };
          return widget!;
        },
        theme: theme,
        initialRoute: Routes.login,
        onGenerateRoute: Routes.onGenerateRouted,
      ),
    );
  }
}
