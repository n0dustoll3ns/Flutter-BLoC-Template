import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../features/catalog/products/model/product.dart';
import '../../../components/product_list/components/product_card.dart';
import '../../../styles/constants.dart';

class BestOffers extends StatelessWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Popular Categories', style: Theme.of(context).textTheme.headline4),
        Column(
          children: [
            GridView.count(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.5,
              children: List.generate(
                  8,
                  (index) => ProductCard(
                      product: Product(
                          name: lorem(paragraphs: 1, words: 3), price: Random().nextInt(55) + 55.99))),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Load more"),
            ),
          ],
        )
      ],
    );
  }
}
