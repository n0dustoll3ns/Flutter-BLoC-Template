import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';

import '../../utils/urls.dart';

class Promo {
  final String id;
  final String title;
  final String announce;
  final String description;
  final DateTime? expireDate;
  final List<String> tizerIds;
  final List<Product> products;
  final double? discountPercentage;
  final String backgroundUrl;
  final String? foregroundUrl;

  Promo({
    required this.id,
    required this.title,
    required this.announce,
    required this.description,
    this.expireDate,
    required this.tizerIds,
    required this.products,
    required this.backgroundUrl,
    this.foregroundUrl,
    this.discountPercentage,
  });

  Promo.fromJson(this.id, Map json, Map expand)
      : title = json['title'],
        announce = json['announce'],
        description = json['description'],
        expireDate = DateTime.tryParse(json['expires']),
        tizerIds = List.from(json['tizers'] ?? []),
        products = expand['products'].map<Product>((model) => Product.fromJson(model.id, model.data)).toList()
            as List<Product>,
        backgroundUrl = "$promoImagesUrl/$id/${json["background"]}",
        foregroundUrl = json["foreground"].isEmpty ? null : "$promoImagesUrl/$id/${json["foreground"]}",
        discountPercentage = json['discount_percentage'].toDouble();
}
