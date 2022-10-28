import 'package:flutter/material.dart';

import '../../app/routes/routes.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).popAndPushNamed(Routes.signIn),
              icon: const Icon(Icons.exit_to_app_sharp))
        ],
      ),
    );
  }
}
