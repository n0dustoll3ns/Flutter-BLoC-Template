import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../features/catalog/products/model/product.dart';

class ProductOfTheDay extends StatelessWidget {
  final Product product;
  const ProductOfTheDay({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.local_fire_department_rounded,
                color: Theme.of(context).primaryColor,
              ),
              Text(
                'Product of the day',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            width: MediaQuery.of(context).size.width - 12,
            decoration: BoxDecoration(
                border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.3)),
                color: Colors.grey.withOpacity(0.06)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    product.img,
                    size: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Icon(Icons.bar_chart_rounded)),
                    SizedBox(width: MediaQuery.of(context).size.width / 44),
                    ElevatedButton(onPressed: () {}, child: const Icon(Icons.shopping_bag_rounded)),
                  ],
                ),
                RatingBar.builder(
                  initialRating: 3,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '• in stock 1000',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.green),
                ),
                Text(
                  '\$${99.99}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Learn more'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
