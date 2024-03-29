import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_bloc_template/features/cart/cart_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/item_page/item_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../app/routes/routes.dart';
import '../../../../features/authentication/auth_bloc.dart';
import '../../../../features/authentication/states.dart';
import '../../../components/undone_feature_snackbar.dart';

class ProductOfTheDay extends StatefulWidget {
  const ProductOfTheDay({super.key});

  @override
  State<ProductOfTheDay> createState() => _ProductOfTheDayState();
}

class _ProductOfTheDayState extends State<ProductOfTheDay> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: ProductsRepository().getProductOfTheDay(token: 'token'),
      builder: (context, asyncSnapshot) {
        return asyncSnapshot.connectionState != ConnectionState.done
            ? const LoadingIndicator()
            : Padding(
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
                            child: asyncSnapshot.data!.imageWidget,
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                  onPressed: () => showBeingDevelopedSnackbar(context),
                                  child: const Icon(Icons.bar_chart_rounded)),
                              SizedBox(width: MediaQuery.of(context).size.width / 44),
                              ElevatedButton(
                                  onPressed: () =>
                                      context.read<CartBloc>().add(AddItem(item: asyncSnapshot.data!)),
                                  child: const Icon(Icons.shopping_bag_rounded)),
                            ],
                          ),
                          RatingBar.builder(
                            initialRating: asyncSnapshot.data!.rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) => actionIfauthorized(
                              () => Navigator.pushNamed(context, Routes.writeReview,
                                  arguments: asyncSnapshot.data!),
                            ),
                          ),
                          Text(
                            asyncSnapshot.data!.name,
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '• in stock 1000',
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.green),
                          ),
                          Text(
                            '\$${99.99}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            asyncSnapshot.data!.name,
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => ProductScreen(product: asyncSnapshot.data!),
                              ),
                            ),
                            child: const Text('Learn more'),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  void actionIfauthorized(Function func) {
    if (context.read<AuthenticationBloc>().state is! AuthenticationAuthenticated) {
      context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: 4));
    } else {
      func();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
