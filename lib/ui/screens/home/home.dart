import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/home_page_data/main_banner/main_banners_bloc.dart';

import '../../../app/routes/constants.dart';
import '../../components/menu_button.dart';
import 'sections/about_shop/about.dart';
import 'sections/banner_slider.dart';
import 'sections/offers.dart';
import 'sections/product_of_the_day.dart';
import 'sections/brands/brands.dart';
import 'sections/popular_categories/popular_categories.dart';
import 'sections/promo/promo_section.dart';
import 'sections/secondary_banner/secondary_banners.dart';
import 'sections/tizers/tizers.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var children = [
      const BannerSlider(),
      const SecondaryBanners(),
      const Tizers(),
      const PopularCategories(),
      const BestOffers(),
      const ProductOfTheDay(),
      const PromoSection(),
      const SectionAbout(),
      const SectionBrands(),
    ];
    return BlocProvider(
      create: (context) => MainBannersBloc()..add(AppStarted()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[0]),
          actions: const [MenuButton()],
        ),
        body: ListView.separated(
          separatorBuilder: ((context, index) => SizedBox(height: MediaQuery.of(context).size.height / 44)),
          itemBuilder: (context, index) => children[index],
          itemCount: children.length,
        ),
      ),
    );
  }
}
