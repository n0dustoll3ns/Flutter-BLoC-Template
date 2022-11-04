import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/theme/theme.dart';
import 'package:flutter_bloc_template/ui/components/persistent_bottom_Bar_scaffold.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/cart/cart.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/favourite/favourites.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/home/home.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/user_profile/user_profile.dart';

import '../../../app/routes/constants.dart';
import '../../../app/routes/routes.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/authentication/auth_bloc.dart';
import 'catalog/catalog.dart';
import 'catalog/product_list/product_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late final AuthenticationBloc authenticationBloc;
  int _selectedTab = 0;
  late final List<PersistentTabItem> _items;
  final _itemsKeys = List.generate(5, (index) => GlobalKey<NavigatorState>());
  @override
  void initState() {
    _items = <PersistentTabItem>[
      PersistentTabItem(tab: const Home(), icon: Icons.home, title: 'Home', navigatorkey: _itemsKeys[0]),
      PersistentTabItem(
          tab: const Category(), icon: Icons.menu, title: 'Category', navigatorkey: _itemsKeys[1]),
      PersistentTabItem(
          tab: const Cart(), icon: Icons.shopping_cart_outlined, title: 'Cart', navigatorkey: _itemsKeys[2]),
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
    ];
    authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      bloc: authenticationBloc,
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
                tab: const Category(), icon: Icons.menu, title: 'Category', navigatorkey: _itemsKeys[1]),
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
