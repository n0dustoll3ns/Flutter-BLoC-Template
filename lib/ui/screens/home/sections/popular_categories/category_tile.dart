import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  const CategoryTile({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.catalog, arguments: category),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.3)),
            color: Colors.grey.withOpacity(0.06)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              category.imageWidget,
              Text(category.name),
            ],
          ),
        ),
      ),
    );
  }
}
