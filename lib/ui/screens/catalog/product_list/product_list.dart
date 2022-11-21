import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/error_container.dart';
import '../../../../features/catalog/categories/model/model.dart';
import '../../../../features/catalog/products/products.dart';
import '../../../../features/catalog/products/products_bloc.dart';
import '../../../styles/constants.dart';
import '../../../widgets/loading_indicator.dart';
import 'components/product_card.dart';

class ProductList extends StatefulWidget {
  final Category? category;
  const ProductList({super.key, this.category});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductsBloc productsBloc;
  bool loadingDialogOpened = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
        bloc: context.read<ProductsBloc>(),
        builder: (context, state) {
          if (state is ProductsFailure) {
            return ErrorBox(message: state.error);
          }
          var productsList = state.products;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.count(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                  children: List<Widget>.generate(productsList.length,
                      (index) => ProductCard(index: index, product: productsList[index]))),
              if (state is ProductsLoading) const LoadingIndicator(),
            ],
          );
        });
  }
}
