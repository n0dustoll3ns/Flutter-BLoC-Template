import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/components/recommended_items.dart';
import 'package:flutter_bloc_template/ui/screens/home/sections/brands/brand_tile.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../features/catalog/products/model/product.dart';
import '../../../styles/constants.dart';
import 'components/characteristics_lines.dart';
import 'components/reviews.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();

  static Route<dynamic> route(RouteSettings routeSettings) {
    var product = routeSettings.arguments as Product;
    return CupertinoPageRoute(builder: (context) => ProductScreen(product: product));
  }
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          Image.asset(
            widget.product.img,
            fit: BoxFit.contain,
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
                  var favouriteBloc = context.read<FavouriteBloc>();
                  return ElevatedButton(
                    onPressed: () {
                      if (state.items.contains(widget.product)) {
                        favouriteBloc.add(DislikeItem(item: widget.product));
                      } else {
                        favouriteBloc.add(LikeItem(item: widget.product));
                      }
                    },
                    child: Row(
                      children: [
                        Icon(state.items.contains(widget.product)
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart),
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
          CharactericticsLines(product: widget.product, maxLines: 7),
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
                  '\$${widget.product.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  '+ ${(widget.product.price / 10).toStringAsFixed(2)} bonuses',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '• in stock: 5',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.green),
                ),
                ElevatedButton(
                    onPressed: () => context.read<CartBloc>().add(AddItem(item: widget.product)),
                    child: const Text('Buy now')),
              ],
            ),
          ),
          SizedBox(
            height: 55,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
              scrollDirection: Axis.horizontal,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => selectedTabIndex = 0),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: selectedTabIndex == 0 ? null : Colors.transparent,
                      foregroundColor: selectedTabIndex == 0 ? null : Theme.of(context).primaryColor),
                  child: const Text('Description'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTabIndex = 1),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: selectedTabIndex == 1 ? null : Colors.transparent,
                      foregroundColor: selectedTabIndex == 1 ? null : Theme.of(context).primaryColor),
                  child: const Text('All Characteristics'),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => selectedTabIndex = 2),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: selectedTabIndex == 2 ? null : Colors.transparent,
                      foregroundColor: selectedTabIndex == 2 ? null : Theme.of(context).primaryColor),
                  child: const Text('Reviews'),
                ),
              ],
            ),
          ),
          [
            Text(
              widget.product.description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CharactericticsLines(
              product: widget.product,
            ),
            ReviewsBox(product: widget.product),
          ][selectedTabIndex],
          RecomendedItems(product: widget.product)
        ],
      ),
    );
  }
}
