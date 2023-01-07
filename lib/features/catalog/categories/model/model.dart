import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../products/model/product.dart';

class Category {
  final List<int> inheritedCategoryIds;
  final String name;
  final int id;
  final List<int> productIds;
  final String description;
  final String? img;
  final String? _icon;
  final List<Product> productList = [];

  Widget get imageWidget => img != null
      ? Image.asset(img!, fit: BoxFit.contain)
      : _icon != null
          ? SvgPicture.asset(_icon!)
          : const Icon(Icons.question_mark_rounded);

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.productIds,
    required this.inheritedCategoryIds,
    String? icon,
    String? img,
  })  : img = img,
        _icon = icon;

  Category.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        productIds = List.from(json['productIds'] ?? []),
        inheritedCategoryIds = List.from(json['inheritedCategoryIds'] ?? []),
        description = json['description'] ?? '',
        img = json['img'],
        _icon = json['icon'];
}
