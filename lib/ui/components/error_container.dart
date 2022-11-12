import 'package:flutter/material.dart';

class ErrorBlock extends StatelessWidget {
  final String message;
  const ErrorBlock({super.key, String? message}) : message = message ?? 'Unknown error';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Text(message),
    );
  }
}
