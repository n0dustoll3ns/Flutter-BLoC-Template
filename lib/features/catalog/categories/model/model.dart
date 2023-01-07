import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../products/model/product.dart';

class Category {
  final List<int> inheritedCategoryIds;
  final String name;
  final String id;
  final List<int> productIds;
  final String description;
  final String? _img;
  final String? _icon;
  final List<Product> productList = [];

  Widget get imageWidget => _img != null
      ? Image.network(_img!, fit: BoxFit.contain)
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
  })  : _img = img,
        _icon = icon;

  Category.fromJson(this.id, Map json)
      : name = json['name'],
        productIds = List.from(json['productIds'] ?? []),
        inheritedCategoryIds = List.from(json['inheritedCategoryIds'] ?? []),
        description = json['description'] ?? '',
        _img = json['image'] != '' ? "$categoriesImagePath/$id/${json['image']}" : null,
        _icon = json['icon'] != '' ? "$categoriesImagePath/$id/${json['icon']}" : null;
}
