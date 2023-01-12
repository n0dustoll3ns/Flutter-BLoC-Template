import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/components/product_list/components/product_card.dart';
import '../../../features/catalog/products/model/product.dart';
import '../../styles/constants.dart';

class ProductsGrid extends StatelessWidget {
  final List<Product> items;
  const ProductsGrid({super.key, required this.items});
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.5,
        children: items.map((e) => ProductCard(product: e)).toList());
  }
}
