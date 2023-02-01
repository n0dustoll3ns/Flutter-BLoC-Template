import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  PaymentMethod({required this.name, required this.description, required this.icon, required this.id});

  PaymentMethod.fromJson({required this.id, required Map json})
      : name = json['name'],
        description = json['description'],
        icon = IconData(json['icon_code'], fontFamily: 'MaterialIcons');
}
