import 'dart:math';

import 'package:pocketbase/pocketbase.dart';

import '../../../utils/urls.dart';
import '../categories/model/model.dart';
import 'model/product.dart';

class ProductsRepository {
  Future<List<Product>> getProductList(
      {required String token, required Category? category, required int skipCount}) async {
    RecordModel response;
    if (category != null) {
      response = await pb.collection('categories').getOne(category.id, expand: 'products');
    } else {
      return [];
    }
    var productMaps = response.expand['products'] ?? List<RecordModel>.empty();
    List<Product> products = (List.generate(
        productMaps.length, (index) => Product.fromJson(productMaps[index].id, productMaps[index].data)));
    return products;
  }

  Future<List<Product>> getRecommendedItems({required String token, required Product product}) async {
    final response = await pb.collection('products').getList(
          page: Random().nextInt(43) + 1,
          perPage: 5,
        );
    var productMaps = response.items;
    List<Product> products = (List.generate(
        productMaps.length, (index) => Product.fromJson(productMaps[index].id, productMaps[index].data)));
    return products;
  }

  Future<Product> getProductOfTheDay({required String token}) async {
    var response = await pb.collection('products').getOne('fw3d5rooti3ueqh');
    Product product = Product.fromJson(response.id, response.data);
    return product;
  }

  Future<Product> getProductInfoById({required String token, required String id}) async {
    var response = await pb.collection('products').getOne(id);
    Product product = Product.fromJson(response.id, response.data);
    return product;
  }

  Future<List<Product>> getBestOffers({required String token}) async {
    var response = await pb.collection('products').getList(
          filter: 'price >= 500 && price < 600',
        );
    var list = response.items;
    List<Product> products =
        (List.generate(list.length, (index) => Product.fromJson(list[index].id, list[index].data)));
    return products;
  }
}
