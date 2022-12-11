import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/catalog/products/model/product.dart';
import '../../../../features/catalog/products/products_repository.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/product_list/components/product_card.dart';
import '../../../styles/constants.dart';

class BestOffers extends StatefulWidget {
  const BestOffers({super.key});

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> {
  late Future<List<Product>> _itemsLoader = ProductsRepository()
      .getProductList(token: context.read<AuthenticationBloc>().state.toString(), skipCount: 0);
  List<Product> items = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Popular Categories', style: Theme.of(context).textTheme.headline4),
        Column(
          children: [
            FutureBuilder(
              future: _itemsLoader,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) items.addAll(snapshot.data!);
                return Column(
                  children: [
                    GridView.count(
                      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 0.5,
                      children: List.generate(
                        items.length,
                        (index) => ProductCard(product: items[index]),
                      ),
                    ),
                    if (snapshot.connectionState != ConnectionState.done) const LoadingIndicator(),
                  ],
                );
              },
            ),
            ElevatedButton(
              onPressed: () async => setState(() => _itemsLoader = ProductsRepository()
                  .getProductList(token: context.read<AuthenticationBloc>().state.toString(), skipCount: 0)),
              child: const Text("Load more"),
            ),
          ],
        )
      ],
    );
  }
}
