import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/promo/model.dart';
import 'package:flutter_bloc_template/ui/components/expiring_timer.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';

class PromotionCard extends StatelessWidget {
  final Promo promo;
  const PromotionCard({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height / 55),
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 1.35,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.center,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.5, 1.0],
                  ),
                ),
                child: Image.network(promo.backgroundUrl, fit: BoxFit.cover)),
            if (promo.foregroundUrl != null) Image.network(promo.foregroundUrl!, fit: BoxFit.fitHeight),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (promo.expireDate != null)
                    Transform.scale(
                      alignment: Alignment.topLeft,
                      scale: 1.3,
                      child: ExpiringTimer(
                        expiringTimer: promo.expireDate!,
                        backgroungColor: Theme.of(context).backgroundColor,
                      ),
                    ),
                  const Spacer(),
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                        'Till ${promo.expireDate?.onlyDate ?? DateTime(DateTime.now().year, DateTime.now().month + 1)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(color: Colors.white.withOpacity(0.72))),
                  ),
                  Text(promo.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: Colors.white.withOpacity(0.8))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
