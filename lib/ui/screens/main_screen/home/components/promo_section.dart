import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/promo/model.dart';

import 'promo_tile.dart';

class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Profitable proposition',
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 44),
        ...List.generate(2, (index) => PromoTile(promo: Promo())),
        ElevatedButton(
          onPressed: () {},
          child: Text("Load more"),
        ),
      ],
    );
  }
}
