import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/menu_button.dart';

import '../../../../app/routes/constants.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[4]),
        actions: const [MenuButton()],
      ),
      body: const Center(child: Text("UserProfile")),
    );
  }
}
