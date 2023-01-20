import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/reviews/model.dart';
import 'package:flutter_bloc_template/features/reviews/reviews_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../features/catalog/products/model/product.dart';

class WriteReviewScreen extends StatefulWidget {
  final Product product;
  const WriteReviewScreen({super.key, required this.product});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();

  static Route route(RouteSettings routeSettings) {
    var product = routeSettings.arguments as Product;
    return CupertinoPageRoute(builder: (context) => WriteReviewScreen(product: product));
  }
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  bool anonimously = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  late AuthenticationBloc userBloc = context.read<AuthenticationBloc>();
  double orderRating = 4;
  double qualityRating = 4;
  double deliveryRating = 4;

  @override
  void initState() {
    nameController.text = (userBloc.state as AuthenticationAuthenticated).userData.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Write new Review')),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 33),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Text(
              'Rate the product ${widget.product.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          TextFormField(
            enabled: !anonimously,
            controller: nameController,
            decoration: InputDecoration(
              label: Text(anonimously ? 'Name hidden' : 'Name'),
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: anonimously,
                onChanged: (value) {
                  setState(() {
                    anonimously = !anonimously;
                    if (anonimously) {
                      nameController.text = '';
                    } else {
                      nameController.text = (userBloc.state as AuthenticationAuthenticated).userData.name;
                    }
                  });
                },
              ),
              const Text('Anonimously'),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Text(
              'Rate your experience',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          RatingBar.builder(
            initialRating: orderRating,
            itemSize: MediaQuery.of(context).size.width / 15,
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              orderRating = rating;
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quality',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: qualityRating,
                    onChanged: (val) => setState(() => qualityRating = val)),
                Text(
                  qualityRating.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: deliveryRating,
                    onChanged: (val) => setState(() => deliveryRating = val)),
                Text(
                  deliveryRating.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: TextFormField(
              minLines: 3,
              maxLines: 5,
              controller: commentController,
              decoration: const InputDecoration(
                label: Text('Your comment'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Text(
              'Add product photo (optional)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 2.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                width: MediaQuery.of(context).size.width / 44,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(Icons.camera_alt_rounded),
                ),
              ),
              itemCount: 5,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: const Text(
              'Supported formats: JPG JPEG PNG',
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: ElevatedButton(
              onPressed: sendReview,
              child: const Text(
                'Send review',
              ),
            ),
          ),
        ],
      ),
    );
  }

  sendReview() {
    context.read<MyReviewsBloc>().add(AddReview(
        item: Review(
            id: '',
            authorId: context.read<AuthenticationAuthenticated>().userData.id,
            productId: widget.product.id,
            anonimously: anonimously,
            comment: commentController.text,
            images: [],
            productRating: qualityRating,
            deliveryRating: deliveryRating)));
    Navigator.of(context).pop();
  }
}
