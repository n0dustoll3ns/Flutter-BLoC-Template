import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../../features/catalog/products/model/product.dart';
import 'characteristics_line.dart';

class CharactericticsLines extends StatelessWidget {
  final Product product;
  final int? maxLines;
  const CharactericticsLines({super.key, required this.product, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(
            min(product.characteristics.length, maxLines ?? product.characteristics.length),
            (index) => CharacteristicLine(
                  characteristic: product.characteristics[index],
                ))
      ],
    );
  }
}
