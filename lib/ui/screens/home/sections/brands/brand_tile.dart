import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';

import '../../../../../app/routes/routes.dart';

class BrandTile extends StatelessWidget {
  final Brand brand;
  const BrandTile({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.brand, arguments: brand),
      child: Container(
        width: MediaQuery.of(context).size.width / 7 * 3,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 66),
        decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(4)),
        child: AspectRatio(
          aspectRatio: 1.88,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.height / 66),
                    child: brand.imageUrl != null
                        ? Image.network(brand.imageUrl!, fit: BoxFit.contain)
                        : const Icon(Icons.question_mark_rounded),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    brand.name,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
