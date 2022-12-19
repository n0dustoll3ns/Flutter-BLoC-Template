import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/features/payment/methods/model.dart';

import '../adresses/model.dart';
import '../reciever/model.dart';

class Order {
  final Reciever reciever;
  final int id;
  final Adress adress;
  final PaymentMethod paymentMethod;
  final List<Product> items;
  final DateTime date;
  Status status = Status.initial;
  double _paid;

  Map<Product, int> get itemsCounted {
    Map<Product, int> res = {for (var item in items.toSet().toList()) item: 0};
    res = res.map((key, value) => MapEntry(key, items.where((item) => item == key).length));
    return res;
  }

  bool get needsPayment => _paid < totalCost;

  double get paid => _paid;

  double get totalCost =>
      items.map((e) => e.price).fold(0.0, (previousValue, itemPrice) => previousValue + itemPrice);

  void addPaidAmount(double amount) {
    if (totalCost - _paid < amount) {
      throw Exception('paid more than required');
    }
    _paid += amount;
  }

  Order({
    required this.reciever,
    required this.adress,
    required this.paymentMethod,
    required this.items,
    double paid = 0,
    int? id,
    DateTime? date,
  })  : _paid = paid,
        id = id ?? 0,
        date = date ?? DateTime.now();
}

enum Status {
  initial,
  canceled,
  inProgress,
  inDelivery,
  done;

  @override
  String toString() => name;
}
