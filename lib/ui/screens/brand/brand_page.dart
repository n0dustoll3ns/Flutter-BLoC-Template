import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/brands/model.dart';
import 'package:pocketbase/pocketbase.dart';

class BrandPage extends StatelessWidget {
  final Brand brand;
  const BrandPage({super.key, required this.brand});

  static Route<dynamic> route(Brand brand) {
    return CupertinoPageRoute(builder: (context) => BrandPage(brand: brand));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
