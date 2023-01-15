import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/products_repository.dart';
import 'package:flutter_bloc_template/ui/screens/promotion/components/discount_label.dart';
import 'package:flutter_bloc_template/ui/screens/promotion/components/expiring_timer.dart';

import '../../../features/catalog/products/model/product.dart';
import '../../../features/promo/model.dart';
import '../../components/loading_indicator.dart';
import '../../components/product_list/components/product_card.dart';
import '../../styles/constants.dart';

class PromotionScreen extends StatelessWidget {
  final Promo promo;
  const PromotionScreen({super.key, required this.promo});

  static Route<PromotionScreen> route(RouteSettings routeSettings) {
    var promo = routeSettings.arguments as Promo;
    return CupertinoPageRoute(builder: (context) => PromotionScreen(promo: promo));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(promo.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(promo.backgroundUrl, fit: BoxFit.cover),
                  if (promo.foregroundUrl != null) Image.network(promo.foregroundUrl!, fit: BoxFit.contain),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
              child: Column(
                children: [
                  Text(
                    promo.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height / 33),
                  Row(
                    children: [
                      if (promo.discountPercentage != null && promo.discountPercentage != 0)
                        DiscountLabel(discount: promo.discountPercentage!),
                      SizedBox(width: MediaQuery.of(context).size.height / 44),
                      if (promo.expireDate != null)
                        ExpiringLabel(expires: promo.expireDate!.difference(DateTime.now())),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 33),
                  const Divider(height: 1),
                  Text(
                    promo.announce,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(height: 1.3, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 44),
                  Text(
                    promo.description,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.3),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 22),
                  FutureBuilder<List<Product>>(
                    future: () async {
                      return ProductsRepository().getProductsByPromo(promo: promo);
                    }.call(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) return const LoadingIndicator();
                      return GridView.count(
                          padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                          children: snapshot.data!.map((product) => ProductCard(product: product)).toList());
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
