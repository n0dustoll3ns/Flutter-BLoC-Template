import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';

class BrandTile extends StatelessWidget {
  final Brand brand;
  const BrandTile({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width / 7 * 3,
        height: MediaQuery.of(context).size.width / 7 * 3 / 2.5,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width / 66),
        decoration: BoxDecoration(
            border: Border.all(width: 0.7, color: Colors.grey.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              brand.img != null ? Image.network(brand.img!) : const Icon(Icons.brightness_auto_sharp),
              Text(
                brand.name,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
