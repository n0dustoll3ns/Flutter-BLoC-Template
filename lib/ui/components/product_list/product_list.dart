import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import '../../../features/catalog/categories/model/model.dart';
import '../../../features/catalog/products/products_bloc.dart';
import 'components/product_card.dart';
import '../../styles/constants.dart';
import '../loading_indicator.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatelessWidget {
  final Category? category; // TODO remove later as unnecessary;
  const ProductList({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogPageProductsBloc, ProductsState>(
      bloc: context.read<CatalogPageProductsBloc>(),
      builder: (context, state) {
        if (state is ProductsFailure) {
          return ErrorWidget.builder(FlutterErrorDetails(exception: Exception(state.errorMessage)));
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.count(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                children: List<Widget>.generate(
                    state.items.length, (index) => ProductCard(product: state.items[index]))),
            if (state is ProductsLoading) const LoadingIndicator(),
          ],
        );
      },
    );
  }
}
