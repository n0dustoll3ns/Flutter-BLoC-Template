import 'dart:math';

import 'package:flutter_bloc_template/features/catalog/products/model/crahacteristic.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'model/product.dart';

class ProductsRepository {
  Future<List<Product>> getProductList({required String token, required int skipCount}) async {
    await Future.delayed(const Duration(milliseconds: 600));
    List<Product> products = (List.generate(
        5,
        (index) => Product(
            id: Random().nextInt(9999999) + 12000,
            name: lorem(paragraphs: 1, words: 2),
            brandID: Random().nextInt(9),
            price: Random().nextInt(55) + 55.99,
            description: lorem(
              paragraphs: 4,
              words: 120,
            ))
          ..characteristics.addAll(List.generate(
              17,
              (index) => Characteristic(
                    name: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                    value: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                  )))));
    return products;
  }

  Future<List<Product>> getRecommendedItems({required String token, required int productId}) async {
    await Future.delayed(const Duration(milliseconds: 900));
    List<Product> products = (List.generate(
        5,
        (index) => Product(
            id: Random().nextInt(9999999) + 12000,
            name: lorem(paragraphs: 1, words: 2),
            brandID: Random().nextInt(9),
            price: Random().nextInt(55) + 55.99,
            description: lorem(
              paragraphs: 4,
              words: 120,
            ))
          ..characteristics.addAll(List.generate(
              17,
              (index) => Characteristic(
                    name: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                    value: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                  )))));
    return products;
  }

  Future<Product> getProductOfTheDay({required String token}) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    Product product = Product(
        id: Random().nextInt(9999999) + 12000,
        name: lorem(paragraphs: 1, words: 2),
        brandID: Random().nextInt(9),
        price: Random().nextInt(55) + 55.99,
        description: lorem(
          paragraphs: 4,
          words: 120,
        ))
      ..characteristics.addAll(List.generate(
          17,
          (index) => Characteristic(
                name: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                value: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
              )));
    return product;
  }

  Future<Product> getProductInfoById({required String token, required int id}) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    Product product = Product(
        id: id,
        name: lorem(paragraphs: 1, words: 2),
        brandID: Random().nextInt(9),
        price: Random().nextInt(55) + 55.99,
        description: lorem(
          paragraphs: 4,
          words: 120,
        ))
      ..characteristics.addAll(List.generate(
          17,
          (index) => Characteristic(
                name: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
                value: lorem(paragraphs: 1, words: 1)..replaceAll('.', ''),
              )));
    return product;
  }
}
