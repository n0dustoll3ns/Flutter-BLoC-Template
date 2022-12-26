import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../components/persistent_bottom_bar_widget.dart';
import 'cart/components/cart_icon.dart';
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
    return PersistentBottomBarScaffold(
      items: <PersistentTabItem>[
        PersistentTabItem(
            tab: const Home(), icon: const Icon(Icons.home), title: 'Home', navigatorkey: itemsKeys[0]),
        PersistentTabItem(
            tab: const CatalogPage(),
            icon: const Icon(Icons.menu),
            title: 'Catalog',
            navigatorkey: itemsKeys[1]),
        PersistentTabItem(
            tab: const Cart(), icon: const CartIcon(), title: 'Cart', navigatorkey: itemsKeys[2]),
        PersistentTabItem(
            tab: const Favourites(),
            icon: const Icon(CupertinoIcons.heart),
            title: 'Favourites',
            navigatorkey: itemsKeys[3]),
        PersistentTabItem(
            tab: const UserProfile(),
            icon: const Icon(Icons.person_outline_rounded),
            title: 'Profile',
            navigatorkey: itemsKeys[4]),
      ],
    );
  }
}
