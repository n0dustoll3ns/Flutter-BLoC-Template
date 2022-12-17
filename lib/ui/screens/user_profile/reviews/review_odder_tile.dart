import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/ui/screens/write_review/write_review_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewOfferTile extends StatelessWidget {
  final Product product;
  const ReviewOfferTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 3,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 38),
            child: Icon(
              product.img,
              size: MediaQuery.of(context).size.width / 3.4,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  product.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  itemSize: MediaQuery.of(context).size.width / 17,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => WriteReviewScreen(product: product)));
                  },
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (context) => WriteReviewScreen(product: product)));
              },
              icon: const Icon(CupertinoIcons.arrow_right))
        ],
      ),
    );
  }
}
