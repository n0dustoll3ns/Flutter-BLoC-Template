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
            min(product.properties.length, maxLines ?? product.properties.length),
            (index) => CharacteristicLine(
                  characteristic: product.properties[index],
                ))
      ],
    );
  }
}
