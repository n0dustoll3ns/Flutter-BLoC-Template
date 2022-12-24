import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

import '../catalog_page.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CatalogPage(category: category)));
      },
      isThreeLine: true,
      leading: category.img != null
          ? Image.asset(
              category.img!,
              fit: BoxFit.contain,
            )
          : const Icon(Icons.question_mark_rounded),
      title: Text(
        category.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: category.description.isNotEmpty
          ? null
          : Text(
              category.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
