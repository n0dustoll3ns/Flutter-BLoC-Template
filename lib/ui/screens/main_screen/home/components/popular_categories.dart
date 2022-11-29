import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/home/components/category_tile.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

import '../../../../../features/catalog/categories/states.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CatalogState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return LoadingIndicator();
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
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              children: List.generate(5, (index) => CategoryTile(category: categories[index])),
            ),
          )
        ],
      );
    });
  }
}
