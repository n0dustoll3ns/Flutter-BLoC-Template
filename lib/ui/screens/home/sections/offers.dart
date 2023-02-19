import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/catalog/products/model/product.dart';
import '../../../../features/catalog/products/products_repository.dart';
import '../../../components/loading_indicator.dart';
import '../../../components/product_list/components/product_card.dart';
import '../../../components/undone_feature_snackbar.dart';
import '../../../styles/constants.dart';

class BestOffers extends StatefulWidget {
  const BestOffers({super.key});

  @override
  State<BestOffers> createState() => _BestOffersState();
}

class _BestOffersState extends State<BestOffers> with AutomaticKeepAliveClientMixin {
  late Future<List<Product>> itemsLoader = ProductsRepository().getBestOffers(
    token: context.read<AuthenticationBloc>().state.toString(),
  );
  List<Product> items = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Text('Best Offers', style: Theme.of(context).textTheme.headline4),
        Column(
          children: [
            FutureBuilder(
              future: itemsLoader,
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
              onPressed: () => showBeingDevelopedSnackber(context),
              child: const Text("Load more"),
            ),
          ],
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
