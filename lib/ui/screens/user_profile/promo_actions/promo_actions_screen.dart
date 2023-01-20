import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../features/promo/main_page_promos_bloc.dart';
import '../../../components/loading_indicator.dart';
import 'promotion_card.dart';

class PromotionsListPage extends StatelessWidget {
  const PromotionsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromosBloc, PromosState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Active promotions'),
        ),
        body: cards(context, state),
      );
    });
  }

  Widget cards(BuildContext context, PromosState state) {
    if (state is! PromosUpdated) return const LoadingIndicator();
    var promotions = state.promotions;
    var map = promotions.map((e) => Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 22),
          child: PromotionCard(promo: e),
        ));
    return ListView(
      children: map.toList(),
    );
  }
}
