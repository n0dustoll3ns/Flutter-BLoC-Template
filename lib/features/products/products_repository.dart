import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/product.dart';

class ProductsRepository {
  List<Cloth> _clothes = [];
  List<Perfumery> _perfumery = [];
  void clear() {
    _clothes.clear();
    _perfumery.clear();
  }

  List<Product> get products {
    List<Product> list = [];
    list.addAll(_clothes);
    list.addAll(_perfumery);
    return list;
  }

  Future<void> getProductList({required String token, required int skipCount}) async {
    await Future.delayed(const Duration(milliseconds: 1500));
    _clothes.addAll(List.generate(5, (index) => Cloth(name: lorem(paragraphs: 1, words: 2))));
    _perfumery.addAll(List.generate(5, (index) => Perfumery(name: lorem(paragraphs: 1, words: 2))));
  }
}
