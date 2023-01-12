import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/brands/brand_page.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_bloc_template/features/catalog/categories/model/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

import '../../components/loading_indicator.dart';
import 'category_filter.dart';
import 'products_graid.dart';

class BrandPage extends StatefulWidget {
  final Brand brand;
  const BrandPage({super.key, required this.brand});

  static Route<BrandPage> route(Brand brand) {
    return CupertinoPageRoute(builder: (context) => BrandPage(brand: brand));
  }

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  List<Category> categories = [];
  List<Product> items = [];
  Category? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BrandPageBloc(brand: widget.brand)..add(BrandPageEntered(brand: widget.brand)),
      child: BlocConsumer<BrandPageBloc, BrandPageBlocsState>(listener: (context, state) {
        items.addAll(state.items);
        categories.addAll(state.categories);
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.brand.name),
          ),
          body: ListView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
            children: [
              if (widget.brand.imageUrl != null)
                SizedBox(
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.network(widget.brand.imageUrl!)),
              Text(
                widget.brand.announce ?? "",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(height: 1.3, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 44),
              Text(
                widget.brand.description ?? "",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.3),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 22),
              const Divider(),
              SizedBox(height: MediaQuery.of(context).size.height / 22),
              Text(
                'The "${widget.brand.name}" products in our shop',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 33),
              CategoryFilters(
                items: categories.map((e) => e.name).toSet().toList(),
                onFilterChange: (filter) {
                  setState(() {
                    _selectedCategory = categories.firstWhere((category) => category.name == filter);
                  });
                },
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 44),
              if (state is BrandPageBlocsLoading) const LoadingIndicator(),
              ProductsGrid(
                  items: _selectedCategory == null
                      ? items
                      : items.where((item) => _selectedCategory!.productIds.contains(item.id)).toList()),
              SizedBox(height: MediaQuery.of(context).size.height / 44),
            ],
          ),
        );
      }),
    );
  }
}
