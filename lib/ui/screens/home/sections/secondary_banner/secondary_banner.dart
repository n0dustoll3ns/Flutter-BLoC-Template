import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/bottom_nav_bar_bloc/bottom_nav_bar_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/secondary_banner/secondary_banner.dart';

class SecondaryBanner extends StatelessWidget {
  final SecondaryBannerInfo details;
  const SecondaryBanner({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (details.moveToTab != null) {
          context.read<BottomNavBarBloc>().add(SetBottomNavBarIndex(index: details.moveToTab!));
        }
      },
      child: SizedBox(
        width: details.isBig ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomLeft,
          children: [
            Image.network(details.imageUrl, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: FractionalOffset.center,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.transparent, Colors.black],
                      stops: [0.2, 1.0])),
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    details.header ?? '',
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white60),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    details.title,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
