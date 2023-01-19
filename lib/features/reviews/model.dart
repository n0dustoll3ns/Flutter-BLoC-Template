class Review {
  final String id;
  final String authorId;
  final String productId;
  final bool anonimously;
  final String? comment;
  List<String> images = [];
  final double productRating;
  final double deliveryRating;

  Review({
    required this.id,
    required this.authorId,
    required this.productId,
    required this.anonimously,
    required this.comment,
    required this.images,
    required this.productRating,
    required this.deliveryRating,
  })  : assert(productRating >= 1 && productRating <= 5 && productRating % 1 == 0),
        assert(deliveryRating >= 1 && deliveryRating <= 5 && deliveryRating % 1 == 0);

  Review.fromJson(this.id, Map json)
      : authorId = json["authorId"],
        productId = json["productId"],
        anonimously = json["anonimously"],
        comment = json["comment"],
        images = List<String>.from(json['images']),
        productRating = json["product_rating"],
        deliveryRating = json["delivery_rating"];
}
