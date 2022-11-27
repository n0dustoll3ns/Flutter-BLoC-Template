import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width / 4,
      backgroundColor: Colors.black12,
      child: Expanded(
          child: FittedBox(
              fit: BoxFit.fill,
              child: Icon(
                Icons.person,
                size: MediaQuery.of(context).size.width / 4,
              ))),
    );
  }
}
