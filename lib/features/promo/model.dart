
import '../../utils/urls.dart';

class Promo {
  final String id;
  final String title;
  final String announce;
  final String description;
  final DateTime? expireDate;
  final List<String> tizerIds;
  final List<String> productIds;
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
    required this.productIds,
    required this.backgroundUrl,
    this.foregroundUrl,
    this.discountPercentage,
  });

  Promo.fromJson(this.id, Map json)
      : title = json['title'],
        announce = json['announce'],
        description = json['description'],
        expireDate = DateTime.tryParse(json['expires']),
        tizerIds = List.from(json['tizers'] ?? []),
        productIds = List.from(json['products'] ?? []),
        backgroundUrl = "$promoImagesUrl/$id/${json["background"]}",
        foregroundUrl = json["foreground"].isEmpty ? null : "$promoImagesUrl/$id/${json["foreground"]}",
        discountPercentage = json['discount_percentage'].toDouble();
}
