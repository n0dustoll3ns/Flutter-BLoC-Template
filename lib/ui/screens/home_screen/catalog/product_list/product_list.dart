import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/products/products.dart';
import 'package:flutter_bloc_template/features/products/products_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/home_screen/catalog/product_list/components/product_card.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
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
          return Column(
            children: [
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding,
                  crossAxisSpacing: kDefaultPadding,
                  children: List.generate(productsList.length,
                      (index) => ProductCard(index: index, product: productsList[index])),
                ),
              ),
            ],
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
