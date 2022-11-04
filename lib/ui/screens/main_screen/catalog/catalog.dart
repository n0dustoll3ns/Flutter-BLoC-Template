import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/categories/catagories.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/components/quick_filters.dart';

import '../../../../features/catalog/categories/categories.dart';
import '../../../../features/catalog/categories/categories_bloc.dart';
import '../../../widgets/loading_indicator.dart';
import 'chapters/chapters_horizontal_view.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isRoot = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: state.selectedCategory == null
              ? const CupertinoTextField(
                  prefix: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.black45,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(5))),
                )
              : IconButton(
                  onPressed: () => context.read<CategoriesBloc>().add(CategoryChange(null)),
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
          actions: state.selectedCategory == null
              ? [
                  PopupMenuButton<Function>(itemBuilder: (context) {
                    return [
                      PopupMenuItem<Function>(
                        value: () {},
                        child: const Text("My Account"),
                      ),
                      PopupMenuItem<Function>(
                        value: () {},
                        child: const Text("Settings"),
                      ),
                      PopupMenuItem<Function>(
                        value: () => context.read<AuthenticationBloc>().add(LoggedOut()),
                        child: const Text("Logout"),
                      ),
                    ];
                  }, onSelected: (value) {
                    value();
                  }),
                ]
              : [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.search,
                    ),
                    onPressed: () {},
                  )
                ],
        ),
        body: (state is CategoriesLoaded)
            ? ListView.custom(
                childrenDelegate: SliverChildListDelegate(
                  [
                    if (state.selectedCategory == null) QuickFilters(onFilterChange: (quickFilter) {}),
                    if (isRoot && state.selectedCategory == null) const ChaptersHorizontalView(),
                    const Categories(),
                  ],
                ),
              )
            : const LoadingIndicator(),
      );
    });
  }
}
