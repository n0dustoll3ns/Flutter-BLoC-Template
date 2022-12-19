import 'package:flutter/material.dart';

class OrderInfo extends StatelessWidget {
  final String title;
  final Widget? child;
  const OrderInfo({super.key, required this.title, this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
