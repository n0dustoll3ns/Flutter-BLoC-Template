import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/home_page_data/tizers/tizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Tizer extends StatelessWidget {
  final TizerInfo details;
  const Tizer({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.network(
            details.iconUrl,
            color: Theme.of(context).primaryColor,
          ),
          Text(
            details.title,
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            details.description,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
