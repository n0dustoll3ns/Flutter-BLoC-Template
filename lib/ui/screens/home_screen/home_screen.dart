import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/app/theme/theme.dart';

import '../../../app/routes/constants.dart';
import '../../../app/routes/routes.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/authentication/auth_bloc.dart';
import 'catalog/catalog.dart';
import 'catalog/product_list/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late final AuthenticationBloc authenticationBloc;
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 5);
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
            title: SizedBox(
              height: 55,
              child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                      mainPageSections.length,
                      (index) =>
                          Align(alignment: Alignment.centerLeft, child: Text(mainPageSections[index])))),
            ),
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
          body: CatalogRoot(),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 2,
            currentIndex: 1,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).iconTheme.color,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                label: mainPageSections[0],
                icon: const Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: mainPageSections[1],
                icon: const Icon(Icons.menu),
              ),
              BottomNavigationBarItem(
                label: mainPageSections[2],
                icon: const Icon(Icons.shopping_cart_outlined),
              ),
              BottomNavigationBarItem(
                label: mainPageSections[3],
                icon: const Icon(CupertinoIcons.heart),
              ),
              BottomNavigationBarItem(
                label: mainPageSections[4],
                icon: const Icon(Icons.person_outline_rounded),
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
