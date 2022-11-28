import 'package:flutter/material.dart';

class Tizer extends StatelessWidget {
  final Widget icon;
  final String text;
  const Tizer({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          Text('data', style: Theme.of(context).textTheme.headline5),
          Text(text),
        ],
      ),
    );
  }
}
