import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_template/ui/screens/catalog/chapters/chapter_card.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';

import '../../../../features/chapter/model.dart';

class ChaptersHorizontalView extends StatelessWidget {
  const ChaptersHorizontalView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 100 * 20,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: kDefaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        scrollDirection: Axis.horizontal,
        itemCount: chapters.length,
        itemBuilder: (context, index) => ChapterCard(chapter: chapters[index]),
      ),
    );
  }
}
