import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/ui/components/product_list/components/product_card.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import '../../../../../features/catalog/products/model/product.dart';
import '../../../../components/carousel_dots.dart';

class RecomendedItems extends StatefulWidget {
  final Product? product;
  const RecomendedItems({super.key, required this.product});

  @override
  State<RecomendedItems> createState() => _RecomendedItemsState();
}

class _RecomendedItemsState extends State<RecomendedItems> with AutomaticKeepAliveClientMixin {
  var dotsCount = 0;
  var activeDotIndex = 0;
  late final _itemsLoader = ProductsRepository().getRecommendedItems(
    token: context.read<AuthenticationBloc>().state.toString(),
    product: widget.product,
  );
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('You also may like', style: Theme.of(context).textTheme.titleLarge),
        FutureBuilder<List<Product>>(
          future: _itemsLoader,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingIndicator();
            }
            var dotsCount = (snapshot.data!.length / 2).round();
            return Column(
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                      onPageChanged: ((index, reason) {
                        setState(() {
                          activeDotIndex = index;
                        });
                      }),
                      aspectRatio: 2.0,
                      enlargeCenterPage: false,
                      viewportFraction: 1,
                      height: MediaQuery.of(context).size.height / 100 * 45),
                  itemCount: dotsCount,
                  itemBuilder: (context, index, realIdx) {
                    final int first = index * 2;
                    final int second = first + 1;
                    return Row(
                      children: [first, second].map((idx) {
                        return Expanded(
                          flex: 1,
                          child: ProductCard(
                            product: snapshot.data![idx],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
                CarouselDots(
                  dotsCount: dotsCount,
                  activeDotIndex: activeDotIndex,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
