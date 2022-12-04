import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../../features/catalog/products/model/product.dart';

class ItemCard extends StatelessWidget {
  final Product item;
  final int count;
  const ItemCard({super.key, required this.item, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              item.img,
              size: MediaQuery.of(context).size.height / 9,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    lorem(paragraphs: 1, words: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'count: $count',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '\$ ${item.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_rounded)),
        ],
      ),
    );
  }
}
