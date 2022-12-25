import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../products/model/product.dart';

class Category {
  List<Category> inheritedCategories = [];
  final String name;
  final int id;
  final List<int> productIds;
  final String description;
  final String? _img;
  final String? _icon;
  final List<Product> productList = [];

  Widget get imageWidget => _img != null
      ? Image.asset(_img!, fit: BoxFit.contain)
      : _icon != null
          ? SvgPicture.asset(_icon!)
          : Icon(Icons.question_mark_rounded);

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.productIds,
    String? icon,
    String? img,
  })  : _img = img,
        _icon = icon;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        productIds = List.from(json['productIds'] ?? []),
        description = json['description'] ?? '',
        _img = json['img'],
        _icon = json['icon'];
}
