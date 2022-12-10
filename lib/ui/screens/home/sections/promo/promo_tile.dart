import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/components/expiring_timer.dart';

import '../../../../../features/promo/model.dart';

class PromoTile extends StatelessWidget {
  final Promo promo;
  const PromoTile({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height / 8,
      child: Row(
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.height / 14,
            child: Icon(
              Icons.savings_outlined,
              size: MediaQuery.of(context).size.height / 18,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  promo.title,
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  promo.preview,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                ExpiringTimer(expiringTimer: promo.expireDate),
              ],
            ),
          )
        ],
      ),
    );
  }
}
