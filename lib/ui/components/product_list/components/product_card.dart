import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../features/catalog/products/model/product.dart';
import '../../../../features/cart/cart_bloc.dart';
import '../../../../features/favourite/favourite_bloc.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    var favouriteBloc = context.read<FavouriteBloc>();
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.3)),
            color: Colors.grey.withOpacity(0.06)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 5,
                  child: Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
                        return IconButton(
                            onPressed: () {
                              if (state.items.contains(product)) {
                                favouriteBloc.add(DislikeItem(item: product));
                              } else {
                                favouriteBloc.add(LikeItem(item: product));
                              }
                            },
                            icon: Icon(
                              CupertinoIcons.heart,
                              color: state.items.contains(product) ? Colors.red : null,
                            ));
                      }),
                      Align(
                          alignment: Alignment.center,
                          child: Icon(product.img, size: MediaQuery.of(context).size.width / 3)),
                    ],
                  )),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Text(
                        '• in stock 1000',
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Colors.green),
                      ),
                      const Spacer(),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        product.name,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(AddItem(item: product));
                        },
                        child: const Text('Add to cart'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
