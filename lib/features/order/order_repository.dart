import 'package:flutter_bloc_template/features/adresses/model.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/payment/methods/model.dart';
import 'package:flutter_bloc_template/features/reciever/model.dart';
import 'package:flutter_bloc_template/utils/urls.dart';
import 'package:pocketbase/pocketbase.dart';

import 'model.dart';

class OrderRepository {
  Future<Order?> createOrder({required Order order, required String token, required String userId}) async {
    try {
      final body = <String, dynamic>{
        "user": userId,
        "reciever": order.reciever.id,
        "adress": order.adress.id,
        "payment_method": order.paymentMethod.id,
        "items": order.items.map((e) => e.id).toList(),
        "paid": null
      };

      await pb.collection('orders').create(body: body);
      return order;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<List<Order>?> loadUserOrderList({required String token}) async {
    try {
      var response = await pb.collection('orders').getFullList(expand: 'reciever, adress, payment_method');
      List<Order> orders = [];
      for (var model in response) {
        var reciever =
            Reciever.fromJson(id: model.expand['reciever']![0].id, json: model.expand['reciever']![0].data);
        var adress =
            Adress.fromJson(id: model.expand['adress']![0].id, json: model.expand['adress']![0].data);
        PaymentMethod paymentMethod = PaymentMethod.fromJson(
            id: model.expand['payment_method']![0].id, json: model.expand['payment_method']![0].data);
        var items = await _getItemsByIds(productIds: List.from(model.data['items']));
        orders.add(Order(
            id: model.id,
            reciever: reciever,
            adress: adress,
            paymentMethod: paymentMethod,
            items: items,
            date: DateTime.tryParse(model.created)));
      }
      return orders;
    } on Exception catch (_) {
      return null;
    }
  }

  Future<List<Product>> _getItemsByIds({required List<String> productIds}) async {
    List<Future<RecordModel>> listLoader = [];
    for (var id in productIds) {
      listLoader.add(pb.collection('products').getOne(
            id,
          ));
    }
    List<RecordModel> list = [];
    for (var modelLoader in listLoader) {
      list.add(await modelLoader);
    }

    return list.map((e) => Product.fromJson(e.id, e.data)).toList();
  }
}
