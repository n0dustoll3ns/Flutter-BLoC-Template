import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/catalog/products/model/product.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/home/components/banner_slider.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/home/components/offers.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import '../../../../app/routes/constants.dart';
import '../../../components/menu_button.dart';
import 'components/popular_categories.dart';
import 'components/product_of_the_day.dart';
import 'components/secondary_banners.dart';
import 'components/tizers.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[0]),
        actions: const [MenuButton()],
      ),
      body: ListView(children: [
        const BannerSlider(),
        const SecondaryBanners(),
        SizedBox(height: MediaQuery.of(context).size.height / 44),
        const Tizers(),
        SizedBox(height: MediaQuery.of(context).size.height / 44),
        const PopularCategories(),
        SizedBox(height: MediaQuery.of(context).size.height / 44),
        const BestOffers(),
        SizedBox(height: MediaQuery.of(context).size.height / 44),
        ProductOfTheDay(product: Product(name: lorem(paragraphs: 1, words: 4)),),
      ]),
    );
  }
}
