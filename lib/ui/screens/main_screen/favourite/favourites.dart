import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/routes/constants.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/authentication.dart';
import '../../../components/menu_button.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[3]),
        actions: const [MenuButton()],
      ),
      body: const Center(child: Text("Favourites")),
    );
  }
}
