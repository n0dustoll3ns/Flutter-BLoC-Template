import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../features/banners/secondary_banner/bloc.dart';
import 'secondary_banner.dart';

class SecondaryBanners extends StatelessWidget {
  const SecondaryBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecondaryBannersBloc(),
      child: BlocBuilder<SecondaryBannersBloc, SecondaryBannersState>(builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Wrap(
            children: [
              SecondaryBanner(isBig: false, img: 1.toString()),
              SecondaryBanner(isBig: false, img: 2.toString()),
              SecondaryBanner(isBig: true, img: 3.toString()),
            ],
          ),
        );
      }),
    );
  }
}
