import 'package:flutter_bloc_template/utils/urls.dart';
import 'package:pocketbase/pocketbase.dart';

import '../catalog/products/model/product.dart';

class CartRepository {
  Future<List<Product>> getCartItemsInfo({required List<String> productIds, required String token}) async {
    List<Future<RecordModel>> listLoader = [];
    for (var id in productIds) {
      listLoader.add(pb.collection('products').getOne(
        id,
        headers: {"Authorization": token},
      ));
    }
    List<RecordModel> list = [];
    for (var modelLoader in listLoader) {
      list.add(await modelLoader);
    }

    return list.map((e) => Product.fromJson(e.id, e.data)).toList();
  }

  Future<void> updateCart(
      {required List<String> productIds, required String token, required String userId}) async {
    var data = {"cart_items": productIds};

    await pb.collection('users').update(
      userId,
      body: data,
      headers: {"Authorization": token},
    );
  }
}
