import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String? avatarUrl;
  const Avatar({super.key, this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: MediaQuery.of(context).size.width / 4,
      backgroundColor: Colors.black12,
      child: avatarUrl == null || avatarUrl!.isEmpty
          ? Icon(
              Icons.person,
              size: MediaQuery.of(context).size.width / 4,
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width / 4),
              child: Image.network(
                avatarUrl!,
                fit: BoxFit.fill,
              ),
            ),
    );
  }
}
