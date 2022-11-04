import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';

import '../../../../features/catalog/categories/categories.dart';
import '../../../../features/catalog/categories/categories_bloc.dart';
import '../catalog.dart';

class CategoryCard extends StatelessWidget {
  final CatalogCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Category(category: category)));
      },
      isThreeLine: true,
      leading: category.img.isEmpty ? const Icon(Icons.question_mark_rounded) : Image.network(category.img),
      title: Text(
        category.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(category.description),
      trailing: const Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
