import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class SectionAbout extends StatelessWidget {
  const SectionAbout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          InkWell(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/${2}.jpg',
                    fit: BoxFit.cover,
                  ),
                  Icon(
                    Icons.play_circle_filled_rounded,
                    size: MediaQuery.of(context).size.width / 8,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Company',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Text(
                  'E-Shop in N-City',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Expanded(
                  child: Text(
                    lorem(paragraphs: 3, words: 115),
                    style: Theme.of(context).textTheme.bodyLarge,
                    overflow: TextOverflow.fade,
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: const Text('Learn more')),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
