import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'tizer.dart';

class Tizers extends StatelessWidget {
  const Tizers({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Tizer(text: lorem(paragraphs: 1, words: 8), icon: Icon(Icons.delivery_dining_outlined)),
        Tizer(text: lorem(paragraphs: 1, words: 8), icon: Icon(Icons.co_present_rounded)),
        Tizer(text: lorem(paragraphs: 1, words: 8), icon: Icon(Icons.card_giftcard_rounded)),
        Tizer(text: lorem(paragraphs: 1, words: 8), icon: Icon(Icons.list_outlined)),
        Tizer(text: lorem(paragraphs: 1, words: 8), icon: Icon(Icons.wallet_rounded)),
      ],
    );
  }
}
