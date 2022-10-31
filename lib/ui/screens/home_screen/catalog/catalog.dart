import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/products/products.dart';
import 'package:flutter_bloc_template/features/products/products_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/home_screen/catalog/components/product_card.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({super.key});

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  late ProductsBloc productsBloc;
  @override
  void initState() {
    productsBloc = context.read<ProductsBloc>();
    productsBloc.add(ProductsPageEnter());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
        bloc: context.read<ProductsBloc>(),
        listener: (context, state) {},
        builder: (context, state) {
          var productsList = productsBloc.productsRepository.products;
          if (state is ProductsUpdated) {
            return GridView.count(
              crossAxisCount: 2,
              children:
                  List.generate(productsList.length, (index) => ProductCard(product: productsList[index])),
            );
          }
          return Center(
            child: LoadingIndicator(),
          );
        });
  }
}
