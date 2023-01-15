import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/app/routes/routes.dart';
import 'package:flutter_bloc_template/ui/components/expiring_timer.dart';

import '../../../../../features/promo/model.dart';

class PromoTile extends StatelessWidget {
  final Promo promo;
  const PromoTile({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.promotionScreen, arguments: promo),
      child: Container(
        padding: const EdgeInsets.all(8),
        height: MediaQuery.of(context).size.height / 8,
        child: Row(
          children: [
            CircleAvatar(
              radius: MediaQuery.of(context).size.height / 15,
              backgroundImage: NetworkImage(promo.backgroundUrl),
              foregroundImage: promo.foregroundUrl == null ? null : NetworkImage(promo.foregroundUrl!),
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
                    promo.announce,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (promo.expireDate != null) ExpiringTimer(expiringTimer: promo.expireDate!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
