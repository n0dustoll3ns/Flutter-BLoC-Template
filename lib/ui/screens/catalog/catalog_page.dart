import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import '../../../features/authentication/user_repository.dart';
import '../../../features/catalog/categories/categories_repository.dart';
import '../../../features/catalog/categories/model/model.dart';
import '../../../features/catalog/categories/states.dart';
import '../../../features/catalog/categories/categories_bloc.dart';
import '../../../features/catalog/products/model/product.dart';
import '../../../features/catalog/products/products_bloc.dart';
import '../../../features/catalog/products/products_repository.dart';
import '../../../features/favourite/favourite_categories.dart';
import 'categories/catagories.dart';
import 'chapters/chapters_horizontal_view.dart';
import '../../components/product_list/product_list.dart';

class CatalogPage extends StatefulWidget {
  final Category? category;
  const CatalogPage({super.key, this.category});

  @override
  State<CatalogPage> createState() => _CatalogPageState();

  static Route<CatalogPage> route(Category? category) {
    return CupertinoPageRoute(builder: (context) => CatalogPage(category: category));
  }
}

class _CatalogPageState extends State<CatalogPage> {
  final ScrollController _scrollController = ScrollController();
  final CatalogPageProductsBloc catalogPageProductsBloc = CatalogPageProductsBloc();
  final List<Product> items = [];

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogPageBloc(
          categoriesRepository: CategoriesRepository(),
          userRepository: UserRepository(),
          productsRepository: ProductsRepository())
        ..add(CatalogPageEnter(category: widget.category)),
      child: BlocProvider<CatalogPageProductsBloc>(
        create: (_) => catalogPageProductsBloc..add(RequestMoreProducts(category: widget.category)),
        child: Scaffold(
            appBar: AppBar(
              title: const CupertinoTextField(
                prefix: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    CupertinoIcons.search,
                    color: Colors.black45,
                  ),
                ),
                decoration:
                    BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              actions: [
                if (widget.category != null)
                  BlocBuilder<FavouriteCategoriesBloc, FavouriteCategoriesState>(builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context.read<FavouriteCategoriesBloc>().add(LikeCategory(item: widget.category!));
                      },
                      icon: Icon(state.categories.contains(widget.category!)
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart),
                    );
                  }),
                ..._actions,
              ],
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              children: [
                // QuickFilters(onFilterChange: (quickFilter) {}),
                const ChaptersHorizontalView(),
                const Categories(),
                const ProductList(),
              ],
            )),
      ),
    );
  }

  List<Widget> get _actions {
    return [
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
    ];
  }

  void _scrollListener() {
    // if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
    //     !_scrollController.position.outOfRange) {
    //   catalogPageProductsBloc.add(RequestMoreProducts(category: widget.category));
    // }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
