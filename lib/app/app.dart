import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/adresses/adresses_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/features/checkout/checkout_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_categories.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/about_shop/bloc.dart' as about_shop;
import 'package:flutter_bloc_template/features/order/orders_bloc.dart';
import 'package:flutter_bloc_template/features/payment/methods/payment_methods.dart';
import 'package:flutter_bloc_template/features/popular_categories/bloc.dart' as popular_categories;
import 'package:flutter_bloc_template/features/promo/main_page_promos_bloc.dart';
import 'package:flutter_bloc_template/features/reciever/recievers_bloc.dart';

import '../features/authentication/auth_bloc.dart';
import '../features/authentication/states.dart';
import '../features/catalog/categories/categories_bloc.dart';
import '../features/catalog/categories/categories_repository.dart';
import '../features/catalog/products/products_bloc.dart';
import '../features/home_page_data/brands_section/bloc.dart' as main_page_brands_bloc;
import '../features/home_page_data/promotions/bloc.dart' as main_page_promotions_bloc;
import '../features/home_page_data/secondary_banner/bloc.dart' as secondary_banners;
import '../features/home_page_data/tizers/bloc.dart' as tizers;
import '../ui/screens/error/error_screen.dart';
import 'routes/routes.dart';
import 'theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var authenticationBloc = AuthenticationBloc();
    authenticationBloc.add(AppStarted());
    var categoriesBloc = CatalogPageBloc(
        userRepository: authenticationBloc.repository,
        categoriesRepository: CategoriesRepository(),
        productsRepository: ProductsRepository());
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => authenticationBloc),
        BlocProvider(create: (_) => CatalogPageProductsBloc()),
        BlocProvider(create: ((_) => categoriesBloc)),
        BlocProvider(create: (_) => CartBloc(authBloc: authenticationBloc)),
        BlocProvider(create: (_) => tizers.TizersBloc()),
        BlocProvider(
            create: (_) =>
                popular_categories.PopularCategoriesBloc()..add(const popular_categories.AppStarted())),
        BlocProvider(
            create: (_) =>
                main_page_brands_bloc.MainPageBrandsBloc()..add(const main_page_brands_bloc.AppStarted())),
        BlocProvider(
            create: (_) => secondary_banners.SecondaryBannersBloc()..add(secondary_banners.AppStarted())),
        BlocProvider(create: (_) => FavouriteBloc()),
        BlocProvider(create: (_) => about_shop.AboutShopBloc()),
        BlocProvider(create: (_) => FavouriteCategoriesBloc()),
        BlocProvider(create: (_) => PromosBloc()..add(InitializePromos())),
        BlocProvider(
            create: (_) => main_page_promotions_bloc.MainPagePromotionsBloc()
              ..add(main_page_promotions_bloc.AppStarted())),
        BlocProvider(create: (_) => RecieversBloc()),
        BlocProvider(create: (_) => AdressesBloc(userRepository: authenticationBloc.repository)),
        BlocProvider(create: (_) => OrdersBloc(authenticationBloc: authenticationBloc)),
        BlocProvider(create: (_) => PaymentMethodsBloc()),
        BlocProvider(create: (_) => BottomNavBarBloc()),
        BlocProvider(create: (context) => CheckoutBloc(ordersBloc: context.read<OrdersBloc>())),
      ],
      child: MaterialApp(
        builder: (BuildContext _, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomError(errorDetails: errorDetails);
          };
          return widget!;
        },
        theme: theme,
        initialRoute: Routes.home,
        onGenerateRoute: Routes.onGenerateRouted,
      ),
    );
  }
}
