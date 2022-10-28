import 'package:flutter/material.dart';

import '../../app/routes/routes.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              TextFormField(),
              TextFormField(),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pushReplacementNamed(Routes.main),
                  child: const Text('Sign in'))
            ],
          ),
        ),
      ),
    );
  }
}
