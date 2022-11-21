import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/chapter/model.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';

class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  const ChapterCard({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 14 / 9,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kDefaultPadding / 4),
          ),
          width: MediaQuery.of(context).size.width / 3,
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 2),
            child: Stack(
              fit: StackFit.expand,
              children: [
                //TODO Replace icon with standart 404 notFoundImage
                if (chapter.img.isEmpty)
                  const Opacity(opacity: 0.33, child: FittedBox(child: Icon(Icons.question_mark_rounded))),
                if (chapter.img.isNotEmpty) Image.network(chapter.img),
                Align(alignment: Alignment.bottomLeft, child: Text(chapter.name)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
