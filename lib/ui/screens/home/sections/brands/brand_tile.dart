import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:flutter_bloc_template/features/brands/repository.dart';
import 'package:flutter_bloc_template/ui/components/loading_indicator.dart';

import '../../../../../app/routes/routes.dart';

class BrandTileLoader extends StatelessWidget {
  final String brandId;
  const BrandTileLoader({super.key, required this.brandId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Brand>(
        future: _loadBrandData(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState != ConnectionState.done) {
            const LoadingIndicator();
          }
          var brand = asyncSnapshot.data!;
          return BrandTile(brand: brand);
        });
  }

  Future<Brand> _loadBrandData() async => BrandsRepository().singleBrandInfo(brandId);
}

class BrandTile extends StatelessWidget {
  final Brand brand;
  const BrandTile({super.key, required this.brand});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, Routes.brand, arguments: brand),
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
    );
  }
}
