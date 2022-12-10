import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/routes/routes.dart';
import '../../features/authentication/states.dart';
import '../../features/authentication/auth_bloc.dart';
import '../../features/catalog/categories/categories_bloc.dart';
import '../components/persistent_bottom_Bar_scaffold.dart';
import 'catalog/catalog_page.dart';
import 'cart/cart.dart';
import 'favourite/favourites.dart';
import 'home/home.dart';
import 'user_profile/user_profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final itemsKeys = List.generate(5, (index) => GlobalKey<NavigatorState>());
    final categoriesState = context.read<CategoriesBloc>().state;

    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: BlocProvider.of<AuthenticationBloc>(context),
      listener: (context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.pushReplacementNamed(context, Routes.signIn);
        }
      },
      builder: (context, state) {
        return PersistentBottomBarScaffold(
          items: <PersistentTabItem>[
            PersistentTabItem(
                tab: const Home(), icon: const Icon(Icons.home), title: 'Home', navigatorkey: itemsKeys[0]),
            PersistentTabItem(
                tab: CatalogPage(category: categoriesState.category),
                icon: const Icon(Icons.menu),
                title: 'Catalog',
                navigatorkey: itemsKeys[1]),
            PersistentTabItem(
                tab: const Cart(),
                icon: const Icon(Icons.shopping_cart_outlined),
                title: 'Cart',
                navigatorkey: itemsKeys[2]),
            PersistentTabItem(
                tab: const Favourites(),
                icon: const Icon(CupertinoIcons.heart),
                title: 'Favourites',
                navigatorkey: itemsKeys[3]),
            PersistentTabItem(
                tab: const UserProfile(),
                icon: const Icon(Icons.person_outline_rounded),
                title: 'UserProfile',
                navigatorkey: itemsKeys[4]),
          ],
        );
      },
    );
  }
}
