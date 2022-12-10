import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/ui/components/product_list/components/product_card.dart';
import 'package:flutter_bloc_template/ui/widgets/loading_indicator.dart';

import '../../../../../features/catalog/products/model/product.dart';

class RecomendedItems extends StatefulWidget {
  final Product product;
  const RecomendedItems({super.key, required this.product});

  @override
  State<RecomendedItems> createState() => _RecomendedItemsState();
}

class _RecomendedItemsState extends State<RecomendedItems> {
  List<Product> items = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('You also may like', style: Theme.of(context).textTheme.titleLarge),
        FutureBuilder<List<Product>>(
          future: ProductsRepository()
              .getProductList(token: context.read<AuthenticationBloc>().state.toString(), skipCount: 0),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingIndicator();
            }
            return CarouselSlider.builder(
              options: CarouselOptions(
                  aspectRatio: 2.0,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height / 100 * 45),
              itemCount: (snapshot.data!.length / 2).round(),
              itemBuilder: (context, index, realIdx) {
                final int first = index * 2;
                final int second = first + 1;
                return Row(
                  children: [first, second].map((idx) {
                    return Expanded(
                      flex: 1,
                      child: ProductCard(
                        product: snapshot.data![index],
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
