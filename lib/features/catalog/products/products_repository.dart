import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/product.dart';

class ProductsRepository {
  Future<List<Product>> getProductList({required String token, required int skipCount}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    List<Product> products = (List.generate(5, (index) => Product(name: lorem(paragraphs: 1, words: 2))));
    return products;
  }
}
