import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/catalog/categories/categories_bloc.dart';
import '../../../../../features/catalog/categories/states.dart';
import '../../../../components/loading_indicator.dart';
import 'category_tile.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CatalogState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const LoadingIndicator();
      }
      var categories = state.category.inheritedCategories;
      return Column(
        children: [
          Text(
            'Popular Categories',
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(5, (index) => CategoryTile(category: categories[index])),
            ),
          )
        ],
      );
    });
  }
}
