import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/states.dart';
import 'package:flutter_bloc_template/features/order/orders_bloc.dart';
import 'package:flutter_bloc_template/features/reviews/reviews_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/reviews/review_odder_tile.dart';
import 'package:flutter_bloc_template/ui/screens/user_profile/reviews/review_tile.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context) {
    var unreviewedProducts = context.read<OrdersBloc>().orderedItems;
    return BlocProvider(
      create: (context) {
        var data = context.read<AuthenticationBloc>().state as AuthenticationAuthenticated;
        return MyReviewsBloc(token: data.token, userData: data.userData);
      },
      child: BlocBuilder<MyReviewsBloc, ReviewsState>(builder: (context, state) {
        if (state is! ReviewsUpdated) {
          return const LoadingIndicator();
        }
        var reviewedProducts = state.items;
        return Scaffold(
          appBar: AppBar(
            title: const Text('My reviews'),
          ),
          body: ListView(
            children: [
              if (reviewedProducts.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 44),
                  child: Text(
                    'You have rated these products',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ...List.generate(
                  reviewedProducts.length, (index) => ReviewTile(review: reviewedProducts[index])),
              if (unreviewedProducts.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width / 44),
                  child: Text(
                    'You have bought these products, write a review about them',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ...List.generate(
                  unreviewedProducts.length, (index) => ReviewOfferTile(product: unreviewedProducts[index]))
            ],
          ),
        );
      }),
    );
  }
}
