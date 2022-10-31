import 'package:flutter/cupertino.dart';
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
  final ScrollController _scrollController = ScrollController();
  bool loadingDialogOpened = false;
  @override
  void initState() {
    productsBloc = context.read<ProductsBloc>();
    _scrollController.addListener(_scrollListener);
    productsBloc.add(ProductsPageEnter());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
        bloc: context.read<ProductsBloc>(),
        listener: (context, state) {
          if (loadingDialogOpened) {
            loadingDialogOpened = false;
            Navigator.of(context).pop();
          }
          if (state is ProductsLoading) {
            loadingDialogOpened = true;
            showCupertinoModalPopup<void>(
              context: context,
              builder: (BuildContext context) => const CupertinoAlertDialog(
                content: LoadingIndicator(),
              ),
            );
          }
        },
        builder: (context, state) {
          var productsList = productsBloc.productsRepository.products;
          return GridView.count(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 17,
            crossAxisSpacing: 17,
            children: List.generate(
                productsList.length, (index) => ProductCard(index: index, product: productsList[index])),
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
