import 'package:flutter/material.dart';

void showBeingDevelopedSnackbar(BuildContext context) {
  var snackBar = const SnackBar(content: Text('This feature is being developed'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
