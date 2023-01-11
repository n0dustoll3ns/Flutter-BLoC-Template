import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';

class BrandPage extends StatelessWidget {
  final Brand brand;
  const BrandPage({super.key, required this.brand});

  static Route<BrandPage> route(Brand brand) {
    return CupertinoPageRoute(builder: (context) => BrandPage(brand: brand));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(brand.name),
      ),
      body: ListView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 44),
        children: [
          if (brand.imageUrl != null)
            SizedBox(height: MediaQuery.of(context).size.width / 2, child: Image.network(brand.imageUrl!)),
          Text(
            brand.announce ?? "",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(height: 1.3, fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 44,
          ),
          Text(
            brand.description ?? "",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(height: 1.3),
          ),
        ],
      ),
    );
  }
}
