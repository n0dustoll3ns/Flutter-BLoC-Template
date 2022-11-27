import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
          3,
          (index) => SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  'assets/images/${index + 1}.jpg',
                  fit: BoxFit.cover,
                ),
              )),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 4,
        viewportFraction: 1.0,
        enlargeCenterPage: true,
        // autoPlay: false,
      ),
    );
  }
}
