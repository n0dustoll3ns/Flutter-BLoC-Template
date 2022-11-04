import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/categories_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/categories/category_card.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

import '../../../../../features/catalog/categories/categories.dart';
import '../../../../styles/constants.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(builder: (context, state) {
      if (state is CategoriesLoaded) {
        return Column(
          children: List.generate(
              state.categories.length * 2,
              (index) => index.isOdd
                  ? const Divider(height: 1)
                  : CategoryCard(
                      category: state.categories[index ~/ 2],
                    )),
        );
      }
      return LoadingIndicator();
    });
  }
}
