import 'package:flutter/material.dart';

import '../../../../features/promo/model.dart';
import 'expiring_timer.dart';

class PromotionTile extends StatelessWidget {
  final Promo promo;
  const PromotionTile({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset.center,
              end: FractionalOffset.bottomCenter,
              colors: [Colors.transparent, Colors.black],
              stops: [0.2, 1.0])),
      height: MediaQuery.of(context).size.height / 1.5,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            promo.backgroundUrl,
            fit: BoxFit.cover,
          ),
          if (promo.foregroundUrl != null)
            Image.network(
              promo.foregroundUrl!,
              fit: BoxFit.contain,
            ),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 22),
            child: Column(
              children: [
                if (promo.expireDate != null) ExpiringTimer(expiringDate: promo.expireDate!),
                const Spacer(),
                if (promo.expireDate != null) Text(_date(promo.expireDate!)),
                Text(
                  promo.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String _date(DateTime dateTime) {
    String dateSlug =
        "${dateTime.year.toString()}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
    return dateSlug;
  }
}
