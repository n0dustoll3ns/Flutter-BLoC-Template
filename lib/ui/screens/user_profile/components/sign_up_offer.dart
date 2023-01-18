import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';

class SignUpOfferSection extends StatelessWidget {
  const SignUpOfferSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => Navigator.of(context).pushNamed(Routes.signUp),
          child: const Text('Create your account or use any service'),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
        )
      ],
    );
  }
}
