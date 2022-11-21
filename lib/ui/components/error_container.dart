import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String message;
  const ErrorBox({super.key, String? message}) : message = message ?? 'Unknown error';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Text(message),
    );
  }
}
