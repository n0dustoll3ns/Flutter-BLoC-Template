import 'package:flutter_bloc_template/utils/urls.dart';

import 'model.dart';

class OrderRepository {
  Future<Order?> createOrder({required Order order, required String token, required String userId}) async {
    try {
      final body = <String, dynamic>{
        "user": userId,
        "reciever": order.reciever.id,
        "adress": order.adress.id,
        "payment_method": order.paymentMethod.name,
        "items": order.items.map((e) => e.id).toList(),
        "paid": null
      };

      await pb.collection('orders').create(body: body);
      return order;
    } on Exception catch (_) {
      return null;
    }
  }
}
