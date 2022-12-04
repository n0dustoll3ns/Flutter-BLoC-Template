import 'package:flutter/material.dart';

class ExpiringTimer extends StatelessWidget {
  final DateTime expiringTimer;
  const ExpiringTimer({super.key, required this.expiringTimer});

  @override
  Widget build(BuildContext context) {
    var delta = expiringTimer.difference(DateTime.now()).abs();
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.8, color: Colors.grey.withOpacity(0.6))),
      // height: 35,
      child:
          Text('${delta.inDays % 31} days : ${delta.inHours % 24} hours : ${delta.inMinutes % 60} minutes'),
    );
  }
}
