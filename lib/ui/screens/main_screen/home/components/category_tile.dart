import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.grey.withOpacity(0.3)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Icon(Icons.dark_mode), Text(category.name)],
        ),
      ),
    );
  }
}
