import 'package:flutter/material.dart';

class WriteReviewCompleteScreen extends StatelessWidget {
  const WriteReviewCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.check,
            size: MediaQuery.of(context).size.width / 4,
          ),
          Text(
            'We fixed your opinion. It will be published soon',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: const Text('Cool!'),
          ),
        ],
      ),
    );
  }
}
