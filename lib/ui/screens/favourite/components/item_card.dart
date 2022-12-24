import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../features/catalog/products/model/product.dart';

class ItemCard extends StatelessWidget {
  final Product item;
  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: item.previewImage != null
                ? Image.asset(
                    item.previewImage!,
                    fit: BoxFit.contain,
                  )
                : const FittedBox(fit: BoxFit.cover, child: Icon(Icons.question_mark_rounded)),
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
          IconButton(
              onPressed: () => context.read<FavouriteBloc>().add(DislikeItem(item: item)),
              icon: const Icon(CupertinoIcons.heart_slash)),
        ],
      ),
    );
  }
}
