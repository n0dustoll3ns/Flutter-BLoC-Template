import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';

class CategoryCard extends StatelessWidget {
  final CatalogCategory category;
  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      leading: category.img.isEmpty ? const Icon(Icons.question_mark_rounded) : Image.network(category.img),
      title: Text(
        category.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(category.description),
      trailing: Icon(Icons.arrow_forward_ios_outlined),
    );
  }
}
