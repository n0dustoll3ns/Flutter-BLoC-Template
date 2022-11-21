import 'package:flutter/material.dart';

class QuickFilter extends StatelessWidget {
  final String name;
  final Function onTap;
  final bool isSelected;
  const QuickFilter({super.key, required this.name, required this.onTap, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isSelected ? null : Colors.transparent,
          foregroundColor: isSelected ? null : Theme.of(context).primaryColor),
      child: Text(name),
    );
  }
}
