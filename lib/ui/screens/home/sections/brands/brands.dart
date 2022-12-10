import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'brand_tile.dart';

class SectionBrands extends StatelessWidget {
  const SectionBrands({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.height / 66),
        mainAxisSpacing: MediaQuery.of(context).size.height / 66,
        crossAxisSpacing: MediaQuery.of(context).size.height / 66,
        childAspectRatio: 1.66,
        crossAxisCount: 2,
        children: List.generate(12, (index) => BrandTile(brand: Brand(name: lorem(paragraphs: 1, words: 1)))),
      ),
    );
  }
}
