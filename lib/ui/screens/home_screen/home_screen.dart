import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/routes.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/authentication/auth_bloc.dart';
import 'catalog/catalog.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    void logout() {
      authenticationBloc.add(LoggedOut());
    }

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
          body: const CatalogView(),
        );
      },
    );
  }
}
