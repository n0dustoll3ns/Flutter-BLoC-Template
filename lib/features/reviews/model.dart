class Review {
  final String comment;
  final bool anonimously;
  final String productId;
  final double orderRating;
  final double qualityRating;
  final double deliveryRating;
  List<String> images = [];

  Review({
    required this.productId,
    required this.comment,
    required this.anonimously,
    required this.orderRating,
    required this.qualityRating,
    required this.deliveryRating,
  });
}
