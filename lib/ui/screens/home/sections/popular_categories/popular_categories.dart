import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/popular_categories/bloc.dart';
import '../../../../components/loading_indicator.dart';
import 'category_tile.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCategoriesBloc, PopularCategoriesState>(builder: (context, state) {
      if (state is PopularCategoriesLoading) return const LoadingIndicator();
      var categories = state.categories;
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
              children:
                  List.generate(categories.length, (index) => CategoryTile(category: categories[index])),
            ),
          )
        ],
      );
    });
  }
}
