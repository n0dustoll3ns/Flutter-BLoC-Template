import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/categories/category_card.dart';


class Categories extends StatelessWidget {
  final List<CatalogCategory> categories;
  const Categories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          categories.length * 2,
          (index) => index.isOdd
              ? const Divider(height: 1)
              : CategoryCard(
                  category: categories[index ~/ 2],
                )),
    );
  }
}
