import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/user/states.dart';
import 'package:flutter_bloc_template/features/user/user_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../features/catalog/products/model/product.dart';

class WriteReviewScreen extends StatefulWidget {
  final Product product;
  const WriteReviewScreen({super.key, required this.product});

  @override
  State<WriteReviewScreen> createState() => _WriteReviewScreenState();
}

class _WriteReviewScreenState extends State<WriteReviewScreen> {
  bool anonimously = false;
  TextEditingController nameController = TextEditingController();
  late UserBloc userBloc = context.read<UserBloc>();
  double quality = 4;
  double delivery = 4;
  @override
  void initState() {
    nameController.text = (userBloc.state as UserDataLoaded).userData.firstName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write new Review'),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 33),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 44),
            child: Text(
              'Rate the product ${widget.product.name}',
              style: Theme.of(context).textTheme.headlineSmall,
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
                      nameController.text = (userBloc.state as UserDataLoaded).userData.firstName;
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
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          RatingBar.builder(
            initialRating: 4,
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
              // print(rating);
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
                Spacer(),
                Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: quality,
                    onChanged: (val) => setState(() => quality = val)),
                Text(
                  quality.toString(),
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
                Spacer(),
                Slider(
                    min: 1,
                    max: 5,
                    divisions: 4,
                    value: delivery,
                    onChanged: (val) => setState(() => delivery = val)),
                Text(
                  delivery.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
