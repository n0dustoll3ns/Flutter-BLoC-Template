import 'dart:math';

import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

import '../adresses/model.dart';
import '../reciever/model.dart';

class Order {
  final Reciever reciever;
  final Adress adress;
  final List<Product> items;
  Status status = Status.initial;
  double _paid = 0;

  double get paid => _paid;

  void addPaidAmount(double amount) {
    if (items.map((e) => e.price).fold(0.0, (previousValue, element) => previousValue + element) - _paid <
        amount) {
      throw Exception('paid more than required');
    }
    _paid += amount;
  }

  Order({
    required this.reciever,
    required this.adress,
    required this.items,
  });
}

enum Status { initial, inProgress, inDelivery, done }
