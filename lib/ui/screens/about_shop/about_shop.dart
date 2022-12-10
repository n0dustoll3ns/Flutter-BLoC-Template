import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class AboutShopScreen extends StatelessWidget {
  const AboutShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Shop',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 22),
        children: [
          Text(lorem(paragraphs: 1, words: 3), style: Theme.of(context).textTheme.headline4),
          Text(lorem(paragraphs: 2, words: 45), style: Theme.of(context).textTheme.bodyLarge),
          Image.asset(
            'assets/images/${1}.jpg',
            fit: BoxFit.fitWidth,
          ),
          Text(lorem(paragraphs: 1, words: 3), style: Theme.of(context).textTheme.headline4),
          Text(lorem(paragraphs: 3, words: 55), style: Theme.of(context).textTheme.bodyLarge),
          Image.asset(
            'assets/images/${2}.jpg',
            fit: BoxFit.fitWidth,
          ),
          Text(lorem(paragraphs: 1, words: 3), style: Theme.of(context).textTheme.headline4),
          Text(lorem(paragraphs: 3, words: 40), style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
