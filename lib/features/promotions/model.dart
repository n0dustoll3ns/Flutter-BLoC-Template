import 'package:flutter_lorem/flutter_lorem.dart';

class Chapter {
  final String name;
  final String description;
  final String? _img;

  Chapter({
    String? img,
    required this.name,
    required this.description,
  }) : _img = img;

  String get img => _img ?? '';
}

List<Chapter> chapters = List.generate(
  4,
  (index) => Chapter(
    name: lorem(paragraphs: 1, words: 7),
    description: lorem(paragraphs: 3, words: 7),
  ),
);
