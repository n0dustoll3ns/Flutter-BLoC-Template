import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/products/model/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: FittedBox(child: Icon(product.img)),
            ),
            const Spacer(),
            Text(product.name),
          ],
        ),
      ),
    );
  }
}
