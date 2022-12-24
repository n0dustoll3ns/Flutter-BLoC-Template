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
  final List<Characteristic> characteristics = [];

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
    characteristics.addAll(List<Characteristic>.generate(
        json['characteristics'].length, (index) => Characteristic.fromJson(json['characteristics'][index])));
  }
}
