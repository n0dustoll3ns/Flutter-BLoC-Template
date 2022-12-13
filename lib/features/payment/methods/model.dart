import 'package:flutter/material.dart';

class PaymentMethod {
  final int id;
  final String name;
  final String description;
  final IconData icon;
  PaymentMethod({required this.name, required this.description, required this.icon, required this.id});
}
