import 'dart:convert';

import 'package:flutter/services.dart';

import 'model/product.dart';

class ProductsRepository {
  Future<List<Product>> getProductList(
      {required String token, required List<int> productIds, required int skipCount}) async {
    List response = jsonDecode(await _readProductsJson());
    var objects = response.where((element) => productIds.contains(element['id'])).toList();
    List<Product> products = (List.generate(objects.length, (index) => Product.fromJson(objects[index])));
    return products;
  }

  Future<List<Product>> getRecommendedItems({required String token, required int productId}) async {
    List response = jsonDecode(await _readProductsJson());
    var objects = response.where((element) => element['id'] < 6 && element['id'] >= 1).toList();
    List<Product> products = (List.generate(objects.length, (index) => Product.fromJson(objects[index])));
    return products;
  }

  Future<Product> getProductOfTheDay({required String token}) async {
    List response = jsonDecode(await _readProductsJson());
    var obj = response.singleWhere((element) => element['id'] == 3);
    Product product = Product.fromJson(obj);
    return product;
  }

  Future<Product> getProductInfoById({required String token, required int id}) async {
    List response = jsonDecode(await _readProductsJson());
    var obj = response.singleWhere((element) => element['id'] == id);
    Product product = Product.fromJson(obj);
    return product;
  }

  Future<String> _readProductsJson() async => await rootBundle.loadString('assets/backend/items.json');
}
