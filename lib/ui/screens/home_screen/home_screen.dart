import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/routes.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/authentication/auth_bloc.dart';
import 'catalog/catalog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AuthenticationBloc authenticationBloc;

  @override
  void initState() {
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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            actions: [
              PopupMenuButton<Function>(itemBuilder: (context) {
                return [
                  PopupMenuItem<Function>(
                    value: () {},
                    child: const Text("My Account"),
                  ),
                  PopupMenuItem<Function>(
                    value: () {},
                    child: const Text("Settings"),
                  ),
                  PopupMenuItem<Function>(
                    value: logout,
                    child: const Text("Logout"),
                  ),
                ];
              }, onSelected: (value) {
                value();
              }),
            ],
          ),
          body: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 17),
            child: CatalogView(),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 2,
            currentIndex: 1,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: 'Catalog',
                icon: Icon(Icons.menu),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Like',
                icon: Icon(CupertinoIcons.heart),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: Icon(Icons.person_outline_rounded),
              ),
            ],
          ),
        );
      },
    );
  }

  void logout() {
    authenticationBloc.add(LoggedOut());
  }
}
