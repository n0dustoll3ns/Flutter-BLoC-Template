import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'offer_tile.dart';

class BestOffers extends StatelessWidget {
  const BestOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Popular Categories', style: Theme.of(context).textTheme.headline4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                children: List.generate(
                    8, (index) => OfferTile(product: Product(name: lorem(paragraphs: 1, words: 3)))),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Load more"),
              ),
            ],
          ),
        )
      ],
    );
  }
}
