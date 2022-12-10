import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/favourite/favourite_products_bloc.dart';

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
              IconButton(onPressed: null, icon: Icon(Icons.share)),
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
                        Expanded(child: Text('To favourite')),
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
              )),
            ],
          )
        ],
      ),
    );
  }
}
