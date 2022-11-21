import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/categories/category_card.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

import '../../../../features/catalog/categories/categories.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CatalogState>(builder: (context, state) {
      if (state is CategoryLoading) {
        return const LoadingIndicator();
      } else if (state is CategoryLoadFailure) {
        return ErrorBox(message: state.error);
      } else if (state is CategoryLoaded) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.category.inheritedCategories.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (BuildContext context, int index) => CategoryCard(
            category: state.category.inheritedCategories[index],
          ),
        );
      }
      return const ErrorBox();
    });
  }
}
