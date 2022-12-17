import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/features/reviews/model.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewTile extends StatelessWidget {
  final Review review;
  const ReviewTile({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ProductsRepository().getProductInfoById(token: 'token', id: review.productId),
      builder: (context, asyncSnapshot) {
        return SizedBox(
          height: MediaQuery.of(context).size.width / 3,
          child: asyncSnapshot.connectionState != ConnectionState.done
              ? Center(child: const LoadingIndicator())
              : Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 38),
                      child: Icon(
                        asyncSnapshot.data!.img,
                        size: MediaQuery.of(context).size.width / 3.4,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            asyncSnapshot.data!.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            asyncSnapshot.data!.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
                          ),
                          RatingBar.builder(
                            ignoreGestures: true,
                            initialRating: review.orderRating,
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
                              // print(rating);
                            },
                          ),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {
                      
                    }, icon: const Icon(CupertinoIcons.arrow_right))
                  ],
                ),
        );
      },
    );
  }
}
