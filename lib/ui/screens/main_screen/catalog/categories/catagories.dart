import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/categories/category_card.dart';

import '../../../../styles/constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

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
