import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: List.generate(
          3,
          (index) => Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/${index + 1}.jpg',
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Banner Headline',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 44),
                        Text(
                          lorem(paragraphs: 1, words: 35),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height / 44),
                        ElevatedButton(onPressed: () {}, child: const Text('Go to calalog'))
                      ],
                    ),
                  )
                ],
              )),
      options: CarouselOptions(
        height: MediaQuery.of(context).size.height / 2,
        viewportFraction: 1,
        // enlargeCenterPage: true,
        // autoPlay: false,
      ),
    );
  }
}
