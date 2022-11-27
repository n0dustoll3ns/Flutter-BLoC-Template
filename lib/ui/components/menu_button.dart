import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/auth_bloc.dart';
import '../../features/authentication/states.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Function>(itemBuilder: (context) {
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
          value: () => context.read<AuthenticationBloc>().add(LoggedOut()),
          child: const Text("Logout"),
        ),
      ];
    }, onSelected: (value) {
      value();
    });
  }
}
