import 'package:flutter/material.dart';

class ExpiringTimer extends StatelessWidget {
  final DateTime expiringDate;
  const ExpiringTimer({super.key, required this.expiringDate});

  @override
  Widget build(BuildContext context) {
    var delta = expiringDate.difference(DateTime.now()).abs();
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 88),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.8, color: Colors.grey.withOpacity(0.6))),
      // height: 35,
      child:
          Text('${delta.inDays % 31} days : ${delta.inHours % 24} hours : ${delta.inMinutes % 60} minutes'),
    );
  }
}
