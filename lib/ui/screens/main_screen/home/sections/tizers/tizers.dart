import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

import 'tizer.dart';

class Tizers extends StatelessWidget {
  const Tizers({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width / 7)),
      child: Wrap(
        runSpacing: MediaQuery.of(context).size.height / 55,
        alignment: WrapAlignment.center,
        children: [
          Tizer(text: lorem(paragraphs: 1, words: 8), icon: const Icon(Icons.delivery_dining_outlined)),
          Tizer(text: lorem(paragraphs: 1, words: 8), icon: const Icon(Icons.co_present_rounded)),
          Tizer(text: lorem(paragraphs: 1, words: 8), icon: const Icon(Icons.card_giftcard_rounded)),
          Tizer(text: lorem(paragraphs: 1, words: 8), icon: const Icon(Icons.list_outlined)),
          Tizer(text: lorem(paragraphs: 1, words: 8), icon: const Icon(Icons.wallet_rounded)),
        ],
      ),
    );
  }
}
