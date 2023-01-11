import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/brands_section/bloc.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import 'brand_tile.dart';

class SectionBrands extends StatelessWidget {
  const SectionBrands({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return BlocBuilder<MainPageBrandsBloc, BrandsState>(builder: (context, state) {
      if (state is BrandsLoading) return const LoadingIndicator();
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: height / 66),
        mainAxisSpacing: height / 66,
        crossAxisSpacing: height / 66,
        childAspectRatio: 1.66,
        crossAxisCount: 2,
        children: state.items.map((e) => BrandTile(brand: e)).toList(),
      );
    });
  }
}
