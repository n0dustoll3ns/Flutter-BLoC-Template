import 'package:flutter_lorem/flutter_lorem.dart';

class Promo {
  final String title;
  final String preview;
  final String fullDescription;
  final DateTime expireDate;

  Promo()
      : title = lorem(paragraphs: 1, words: 3),
        preview = lorem(paragraphs: 1, words: 16),
        fullDescription = lorem(paragraphs: 3, words: 22),
        expireDate = DateTime(DateTime.now().year, DateTime.now().month + 2);
}
