import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';
import '../../../features/catalog/products/states.dart';
import '../../../features/catalog/products/products_bloc.dart';
import 'components/product_card.dart';
import '../../styles/constants.dart';
import '../loading_indicator.dart';

class ProductList extends StatelessWidget {
  final List<Product> items;
  const ProductList({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
        bloc: context.read<ProductsBloc>(),
        builder: (context, state) {
          if (state is ProductsFailure) return ErrorBox(message: state.error);
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
