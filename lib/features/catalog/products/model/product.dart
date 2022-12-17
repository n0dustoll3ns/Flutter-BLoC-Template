import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/crahacteristic.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final IconData img;
  final double price;
  final int? brandID;
  final List<Characteristic> characteristics = [];

  Product(
      {required this.id, required this.name, required this.price, required this.description, this.brandID})
      : img = icons[Random().nextInt(icons.length - 1)];
}

const List<IconData> icons = [
  Icons.propane_tank_rounded,
  Icons.access_alarm_sharp,
  Icons.account_balance_wallet,
  Icons.work_outline_outlined,
  Icons.wine_bar_rounded,
  Icons.icecream,
  Icons.ice_skating_rounded,
  Icons.image,
  Icons.umbrella_rounded,
  Icons.two_wheeler_rounded,
  Icons.tv_sharp,
  Icons.tungsten_sharp,
  Icons.time_to_leave_rounded,
  Icons.tablet_android_outlined,
  Icons.table_bar_sharp,
  Icons.sports_tennis_rounded,
  Icons.sports_soccer_rounded,
  Icons.sports_rugby_rounded,
];
