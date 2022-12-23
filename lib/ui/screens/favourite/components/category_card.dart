import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_categories.dart';

import '../../../../features/catalog/categories/model/model.dart';
import '../../catalog/catalog_page.dart';

class FavourteCategoryCard extends StatelessWidget {
  final Category category;
  const FavourteCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => CatalogPage(category: category)));
      },
      isThreeLine: true,
      leading: category.img == null ? const Icon(Icons.question_mark_rounded) : Image.network(category.img!),
      title: Text(
        category.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(category.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () => context.read<FavouriteCategoriesBloc>().add(DislikeCategory(item: category)),
              icon: const Icon(
                CupertinoIcons.heart_slash,
              )),
          const Icon(Icons.arrow_forward_ios_outlined),
        ],
      ),
    );
  }
}
