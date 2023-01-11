import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import '../../../../../features/home_page_data/secondary_banner/bloc.dart';
import 'secondary_banner.dart';

class SecondaryBanners extends StatelessWidget {
  const SecondaryBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondaryBannersBloc, SecondaryBannersState>(builder: (context, state) {
      if (state is SecondaryBannersLoading) {
        return const LoadingIndicator();
      }
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        child: Wrap(
          children: state.items.map((e) => SecondaryBanner(details: e)).toList(),
        ),
      );
    });
  }
}
