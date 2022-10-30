import 'dart:math';

import 'package:flutter/material.dart';

abstract class Product {
  final String name;
  final IconData img;

  Product({required this.name}) : img = icons[Random().nextInt(9)];
}

class Perfumery extends Product {
  Perfumery({required super.name});
}

class Cloth extends Product {
  Cloth({required super.name});
}

const List<IconData> icons = [
  Icons.propane_tank_rounded,
  Icons.access_alarm_sharp,
  Icons.account_balance_wallet,
  Icons.account_tree_sharp,
  Icons.adb_sharp,
  Icons.ads_click_sharp,
  Icons.workspaces_sharp,
  Icons.work_outline_outlined,
  Icons.wine_bar_rounded,
  Icons.whatshot
];
