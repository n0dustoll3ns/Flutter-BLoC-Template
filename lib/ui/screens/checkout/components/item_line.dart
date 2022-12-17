import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

class ItemLine extends StatelessWidget {
  final Product item;
  final int count;
  const ItemLine({super.key, required this.item, required this.count});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          item.img,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 44,
        ),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '\$${item.price.toStringAsFixed(2)} • $count pieces',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ))
      ],
    );
  }
}
