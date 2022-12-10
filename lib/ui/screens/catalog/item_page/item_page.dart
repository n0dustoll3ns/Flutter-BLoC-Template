import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/components/characteristics_line.dart';
import 'package:flutter_bloc_template/ui/screens/home/sections/brands/brand_tile.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../features/catalog/products/model/product.dart';

class ProductScreen1 extends StatelessWidget {
  final Product product;
  const ProductScreen1({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              const IconButton(onPressed: null, icon: Icon(Icons.share)),
            ],
          ),
          FittedBox(fit: BoxFit.fitWidth, child: Icon(product.img)),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
                  var favouriteBloc = context.read<FavouriteBloc>();
                  return ElevatedButton(
                    onPressed: () {
                      if (state.items.contains(product)) {
                        favouriteBloc.add(DislikeItem(item: product));
                      } else {
                        favouriteBloc.add(LikeItem(item: product));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(
                            state.items.contains(product) ? CupertinoIcons.heart_fill : CupertinoIcons.heart),
                        SizedBox(width: MediaQuery.of(context).size.width / 44),
                        const Expanded(child: Text('To favourite')),
                      ],
                    ),
                  );
                }),
              )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Row(
                      children: const [
                        Icon(Icons.bar_chart_rounded),
                        Text('Compare'),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: RatingBar.builder(
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
              ),
              SizedBox(
                child: BrandTile(
                  brand: Brand(name: lorem(paragraphs: 1, words: 1)),
                ),
              )
            ],
          ),
          const Divider(),
          Text(
            'Charatceristics',
            style: Theme.of(context).textTheme.headline6,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...List.generate(
                  product.characteristics.length,
                  (index) => CharacteristicLine(
                        characteristic: product.characteristics[index],
                      ))
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 44),
          Container(
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '+ ${(product.price / 10).toStringAsFixed(2)} bonuses',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '• in stock: 5',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green),
                ),
                ElevatedButton(
                    onPressed: () => context.read<CartBloc>().add(AddItem(item: product)),
                    child: const Text('Buy now')),
                    
              ],
            ),
          ),
        ],
      ),
    );
  }
}
