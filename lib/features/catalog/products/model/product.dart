import 'package:flutter_bloc_template/features/catalog/products/model/crahacteristic.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final int? previewImgIndex;
  final List<String> images;
  String? get previewImage => images.isEmpty ? null : images[previewImgIndex ?? 0];
  final double price;
  final int? brandId;
  final List<Property> properties = [];

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.images,
    this.brandId,
    this.previewImgIndex,
  });

  Product.fromJson(Map json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        previewImgIndex = json['previewImgIndex'],
        images = List<String>.from(json['images']),
        price = json['price'],
        brandId = json['brandId'] {
    properties.addAll(List<Property>.generate(
        json['properties'].length, (index) => Property.fromJson(json['characteristics'][index])));
  }
}
