import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import '../../../features/catalog/products/products_bloc.dart';
import 'components/product_card.dart';
import '../../styles/constants.dart';
import '../loading_indicator.dart';

class ProductList extends StatelessWidget {
  final List<Product> items;
  const ProductList({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogPageProductsBloc, ProductsState>(
        bloc: context.read<CatalogPageProductsBloc>(),
        builder: (context, state) {
          if (state is ProductsFailure) {
            return ErrorWidget.builder(FlutterErrorDetails(exception: Exception(state.errorMessage)));
          }
          if (state is ProductsUpdated) items.addAll(state.items);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  children:
                      List<Widget>.generate(items.length, (index) => ProductCard(product: items[index]))),
              if (state is ProductsLoading) const LoadingIndicator(),
            ],
          );
        });
  }
}
