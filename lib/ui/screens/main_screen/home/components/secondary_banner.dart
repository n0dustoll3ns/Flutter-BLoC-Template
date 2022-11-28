import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class SecondaryBanner extends StatelessWidget {
  final bool isBig;
  final String img;
  const SecondaryBanner({super.key, required this.isBig, required this.img});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isBig ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.width / 2,
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomLeft,
        children: [
          Image.asset('assets/images/$img.jpg', fit: BoxFit.cover),
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset.center,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.0, 1.0])),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Headline',
                  style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.white60),
                ),
                Text(
                  lorem(paragraphs: 1, words: 4),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
