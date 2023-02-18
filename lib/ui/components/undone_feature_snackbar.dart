import 'package:flutter/material.dart';

void showBeingDevelopedSnackber(BuildContext context) {
  var snackBar = const SnackBar(content: Text('This feature is being developed'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
