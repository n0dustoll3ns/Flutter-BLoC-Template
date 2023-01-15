import 'package:flutter/material.dart';

class DiscountLabel extends StatelessWidget {
  final double discount;
  const DiscountLabel({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 88),
      decoration: BoxDecoration(
        color: const Color(0xffFBDC40),
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 122),
      ),
      child: Text(
        "-${discount.toStringAsFixed(0)}%",
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
