import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/authentication.dart';
import '../../../features/catalog/categories/categories.dart';
import '../../../features/catalog/categories/categories_bloc.dart';
import '../../../features/catalog/products/products_bloc.dart';
import '../../widgets/loading_indicator.dart';
import 'categories/catagories.dart';
import 'chapters/chapters_horizontal_view.dart';
import 'components/quick_filters.dart';
import 'product_list/product_list.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final ScrollController _scrollController = ScrollController();
  late final CategoriesBloc categoriesBloc;
  late final ProductsBloc productsBloc;

  @override
  void initState() {
    categoriesBloc = context.read<CategoriesBloc>();
    productsBloc = context.read<ProductsBloc>();
    categoriesBloc.add(const ApplicationStarted());
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CatalogState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: state is CategoryLoading
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
        body: (state is CategoryLoaded)
            ? ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _scrollController,
                children: [
                  QuickFilters(onFilterChange: (quickFilter) {}),
                  const ChaptersHorizontalView(),
                  Categories(category: state.category),
                  ProductList(category: state.category),
                ],
              )
            : const LoadingIndicator(),
      );
    });
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      productsBloc.add(const ProductsRequest());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
