import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/categories/category_card.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import '../../../../features/catalog/categories/states.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogPageBloc, CatalogPageState>(builder: (context, state) {
      if (state is CatalogPageLoading) {
        return const LoadingIndicator();
      } else if (state is CatalogPageLoadFailure) {
        return ErrorBox(message: state.error);
      } else if (state is CatalogPageLoaded) {
        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: state.categories.length,
          separatorBuilder: (context, index) => const Divider(height: 1),
          itemBuilder: (BuildContext context, int index) => CategoryCard(
            category: state.categories[index],
          ),
        );
      }
      return const ErrorBox();
    });
  }
}
