import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Category {
  final List<int> inheritedCategoryIds;
  final String name;
  final String id;
  final List<String> productIds;
  final String description;
  final String? _img;
  final String? _icon;

  Widget get imageWidget => _img != null
      ? Image.network("$categoriesFilesUrl/$id/${_img!}", fit: BoxFit.contain)
      : _icon != null
          ? SvgPicture.network("$categoriesFilesUrl/$id/${_icon!}")
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
        productIds = List.from(json['products'] ?? []),
        inheritedCategoryIds = List.from(json['inheritedCategoryIds'] ?? []),
        description = json['description'] ?? '',
        _img = json['image'] != '' ? "${json['image']}" : null,
        _icon = json['icon'] != '' ? "${json['icon']}" : null;
}
