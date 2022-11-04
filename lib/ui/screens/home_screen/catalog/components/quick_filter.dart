import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class QuickFilter extends StatelessWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  const QuickFilter({super.key, required this.name, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(name),
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? null : Colors.transparent,
          foregroundColor: isSelected ? null : Theme.of(context).primaryColor),
    );
  }
}
