import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';
import 'package:flutter_bloc_template/features/promo/model.dart';
import 'package:flutter_bloc_template/features/promo/repository.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/components/recommended_items.dart';
import 'package:flutter_bloc_template/ui/screens/home/sections/brands/brand_tile.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../app/routes/routes.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../../features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import '../../../../features/brands/model.dart';
import '../../../../features/brands/repository.dart';
import '../../../../features/catalog/products/model/product.dart';
import '../../../components/undone_feature_snackbar.dart';
import '../../../styles/constants.dart';
import 'components/characteristics_lines.dart';
import 'components/reviews.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();

  static Route<ProductScreen> route(Product product) {
    return CupertinoPageRoute(builder: (context) => ProductScreen(product: product));
  }
}

class _ProductScreenState extends State<ProductScreen> {
  int selectedTabIndex = 0;

  late Future<List<Promo>> promosLoader =
      Future<List<Promo>>(() async => await PromoRepository().loadPromosOf(widget.product));
  late Future<Brand>? brandLoader = widget.product.brandId != null
      ? Future<Brand>(() async => await BrandsRepository().singleBrandInfo(widget.product.brandId!))
      : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        actions: [
          IconButton(onPressed: () => showBeingDevelopedSnackbar(context), icon: const Icon(Icons.share))
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
        children: [
          widget.product.imageWidget,
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: RatingBar.builder(
                    initialRating: widget.product.rating,
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
                    onRatingUpdate: (rating) => actionIfauthorized(
                          () => Navigator.pushNamed(context, Routes.writeReview, arguments: widget.product),
                        )),
              ),
              if (widget.product.brandId != null && widget.product.brandId != '')
                FutureBuilder<Brand>(
                    future: brandLoader,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const LoadingIndicator();
                      }
                      var brand = snapshot.data!;
                      return BrandTile(brand: brand);
                    }),
            ],
          ),
          const Divider(),
          Text(
            'Characteristics',
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
          SizedBox(height: MediaQuery.of(context).size.height / 44),
          FutureBuilder<List<Promo>>(
            future: promosLoader,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) return const LoadingIndicator();
              return snapshot.data!.isNotEmpty
                  ? Row(
                      children: [
                        Icon(
                          CupertinoIcons.bolt,
                          color: Theme.of(context).primaryColor,
                          size: MediaQuery.of(context).size.height / 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                'The product is included to promotions',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
                                overflow: TextOverflow.ellipsis,
                              ),
                              ...snapshot.data!.map(
                                (promo) => InkWell(
                                  onTap: () =>
                                      Navigator.pushNamed(context, Routes.promotionScreen, arguments: promo),
                                  child: Text(
                                    promo.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        decoration: TextDecoration.underline,
                                        height: 1.2,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  : const SizedBox();
            },
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

  void actionIfauthorized(Function func) {
    if (context.read<AuthenticationBloc>().state is! AuthenticationAuthenticated) {
      context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 4));
    } else {
      func();
    }
  }
}
