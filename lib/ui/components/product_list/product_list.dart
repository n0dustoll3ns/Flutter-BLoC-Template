import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import '../../../features/catalog/categories/model/model.dart';
import '../../../features/catalog/products/products_bloc.dart';
import 'components/product_card.dart';
import '../../styles/constants.dart';
import '../loading_indicator.dart';
import 'package:http/http.dart' as http;

class ProductList extends StatelessWidget {
  final Category? category; // TODO remove later as unnecessary;
  const ProductList({super.key, required this.category});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogPageProductsBloc, ProductsState>(
      bloc: context.read<CatalogPageProductsBloc>(),
      builder: (context, state) {
        if (state is ProductsFailure) {
          return ErrorWidget.builder(FlutterErrorDetails(exception: Exception(state.errorMessage)));
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(onPressed: () => addToPb(context), child: Text('UploadProducts')),
            GridView.count(
                padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                children: List<Widget>.generate(
                    state.items.length, (index) => ProductCard(product: state.items[index]))),
            if (state is ProductsLoading) const LoadingIndicator(),
          ],
        );
      },
    );
  }

  Future<void> addToPb(BuildContext context) async {
    var bloc = context.read<CatalogPageProductsBloc>();
    AdminAuth adminAuth = AdminAuth();
    var authState = context.read<AuthenticationBloc>().state;
    if (authState is AuthenticationAuthenticated) {
      adminAuth = authState.authData;
    }
    final pb = PocketBase('https://pocketbase.dancheg97.ru',
        authStore: AuthStore()..save(adminAuth.token, adminAuth.admin));

    for (var product in bloc.state.items) {
      var futureImages = product.images
          .map((e) async => http.MultipartFile.fromBytes(
                'images',
                (await rootBundle.load(e)).buffer.asInt8List(),
                filename: e.substring(e.lastIndexOf('/') + 1),
              ))
          .toList();
      List<http.MultipartFile> images = [];

      for (var file in futureImages) {
        images.add(await file);
      }

      final body = <String, dynamic>{
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "rating": product.rating,
        "images": product.images.map((e) => e.substring(e.lastIndexOf('/') + 1)).toList(),
      };
      final record = await pb.collection('products').create(body: body, files: images);

      print(record.id);
      print("\n========================\n");
    }
  }
}
