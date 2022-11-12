import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/routes.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/catalog/categories/categories_bloc.dart';
import '../../components/persistent_bottom_Bar_scaffold.dart';
import '../catalog/catalog_page.dart';
import 'cart/cart.dart';
import 'favourite/favourites.dart';
import 'home/home.dart';
import 'user_profile/user_profile.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _itemsKeys = List.generate(5, (index) => GlobalKey<NavigatorState>());
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
                tab: const Home(), icon: Icons.home, title: 'Home', navigatorkey: _itemsKeys[0]),
            PersistentTabItem(
                tab: CatalogPage(), icon: Icons.menu, title: 'Category', navigatorkey: _itemsKeys[1]),
            PersistentTabItem(
                tab: const Cart(),
                icon: Icons.shopping_cart_outlined,
                title: 'Cart',
                navigatorkey: _itemsKeys[2]),
            PersistentTabItem(
                tab: const Favourites(),
                icon: CupertinoIcons.heart,
                title: 'Favourites',
                navigatorkey: _itemsKeys[3]),
            PersistentTabItem(
                tab: const UserProfile(),
                icon: Icons.person_outline_rounded,
                title: 'UserProfile',
                navigatorkey: _itemsKeys[4]),
          ],
        );
      },
    );
  }
}
