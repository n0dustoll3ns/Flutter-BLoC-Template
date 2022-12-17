import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/reviews/model.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width / 3,
    );
  }
}
