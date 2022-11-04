import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/categories/catagories.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/components/quick_filters.dart';

import '../../../features/catalog/categories/categories.dart';
import '../../../features/catalog/categories/categories_bloc.dart';
import '../../widgets/loading_indicator.dart';
import 'chapters/chapters_horizontal_view.dart';

class Category extends StatefulWidget {
  final CatalogCategory? category;
  final bool isRoot;
  const Category({super.key, this.category}) : isRoot = category == null;

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: state is CategoriesLoading
              ? null
              : const CupertinoTextField(
                  prefix: Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.black45,
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
          actions: [
            PopupMenuButton<Function>(
                itemBuilder: (context) {
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
                },
                onSelected: (value) => value()),
          ],
        ),
        body: (state is CategoriesLoaded)
            ? ListView.custom(
                childrenDelegate: SliverChildListDelegate(
                  [
                    if (widget.isRoot) QuickFilters(onFilterChange: (quickFilter) {}),
                    if (widget.isRoot) const ChaptersHorizontalView(),
                    Categories(categories: widget.category?.inheritedCategories ?? state.categories),
                  ],
                ),
              )
            : const LoadingIndicator(),
      );
    });
  }
}
