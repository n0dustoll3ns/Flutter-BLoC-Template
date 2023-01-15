import 'package:flutter/material.dart';

class ExpiringLabel extends StatelessWidget {
  final Duration expires;
  const ExpiringLabel({super.key, required this.expires});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height / 88),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 122),
        border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.6)),
      ),
      child: Text(
        '${expires.inDays % 31} days : ${expires.inHours % 24} hours : ${expires.inMinutes % 60} minutes',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
