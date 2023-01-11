import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/crahacteristic.dart';

import '../../../../utils/urls.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final int? previewImgIndex;
  final List<String> images;
  String? get _previewImage => images.isEmpty ? null : images[previewImgIndex ?? 0];
  final double price;
  final double rating;
  final String? brandId;
  final List<Property> properties = [];

  Widget get imageWidget => _previewImage != null
      ? Image.network(
          "$productsFilesUrl/$id/${_previewImage!}",
          fit: BoxFit.contain,
          loadingBuilder: (context, widget, loadingProgress) =>
              loadingProgress == null ? widget : const CircularProgressIndicator(),
        )
      : const FittedBox(fit: BoxFit.contain, child: Icon(Icons.question_mark_rounded));

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    required this.rating,
    this.brandId,
    this.previewImgIndex,
  });

  Product.fromJson(this.id, Map json)
      : name = json['name'],
        description = json['description'],
        previewImgIndex = json['previewImgIndex'],
        images = List<String>.from(json['images']),
        price = json['price'],
        rating = json['rating'].toDouble(),
        brandId = json['brandId'] {
    if (json['properties'] != null) {
      properties.addAll(List<Property>.generate(
          json['properties'].length, (index) => Property.fromJson(json['characteristics'][index])));
    }
  }
}

class ProductWithOffers {}

class Characteristic {
  final String name;
  List<String> values;
  int selectedIndex = 0;

  Characteristic({required this.name, required this.values}) : assert(values.isNotEmpty);
}
