import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsBox extends StatelessWidget {
  const ReviewsBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Reviews',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Row(
          children: [
            RatingBar.builder(
              initialRating: 3,
              itemSize: MediaQuery.of(context).size.width / 15,
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
            Expanded(
              child: Text(
                'No Reviews',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Write review'),
        ),
        Container(
          padding: const EdgeInsets.all(32),
          child: Text(
            'Help other users with a choice - be the first to share your opinion about this product',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
