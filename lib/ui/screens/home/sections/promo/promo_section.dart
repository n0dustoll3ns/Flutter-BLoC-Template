import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import '../../../../../features/home_page_data/promotions/bloc.dart';
import 'promo_tile.dart';

class PromoSection extends StatelessWidget {
  const PromoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPagePromotionsBloc, MainPagePromotionsState>(builder: (context, state) {
      return Column(
        children: [
          Text(
            'Profitable proposition',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 44),
          ...state.items.map((promo) => PromoTile(promo: promo)),
          if (state is MainPagePromotionsLoading) const LoadingIndicator(),
          ElevatedButton(
            onPressed: () {
              context.read<MainPagePromotionsBloc>().add(LoadMoreButtonPressed());
            },
            child: const Text("Load more"),
          ),
        ],
      );
    });
  }
}
