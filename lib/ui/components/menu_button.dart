import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';

import '../../features/authentication/auth_bloc.dart';
import '../../features/authentication/states.dart';
import 'undone_feature_snackbar.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<Function>(itemBuilder: (context) {
      return [
        PopupMenuItem<Function>(
          value: () => context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 4)),
          child: const Text("My account"),
        ),
        PopupMenuItem<Function>(
          value: () => showBeingDevelopedSnackbar(context),
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
