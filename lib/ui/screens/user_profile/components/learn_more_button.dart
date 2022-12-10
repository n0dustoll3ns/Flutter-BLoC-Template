import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/loyalty_program/loyalty_program_screen.dart';

class LearnMore extends StatelessWidget {
  const LearnMore({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          child: const Text('Learn more about loyalty program'),
          onPressed: () => Navigator.of(context).push(
            CupertinoPageRoute(builder: ((context) => const LoyaltyProgramScreen())),
          ),
        ),
      ),
    );
  }
}
