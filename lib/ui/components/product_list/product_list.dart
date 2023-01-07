import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import '../../../features/authentication/auth_bloc.dart';
import '../../../features/authentication/states.dart';
import '../../../features/catalog/categories/model/model.dart';
import '../../../features/catalog/products/products_bloc.dart';
import 'components/product_card.dart';
import '../../styles/constants.dart';
import '../loading_indicator.dart';

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
    final pb =
        PocketBase('http://10.0.2.2:8090', authStore: AuthStore()..save(adminAuth.token, adminAuth.admin));

    for (var product in bloc.state.items) {
      final body = <String, dynamic>{
        "category": category!.id,
        "name": product.name,
        "description": product.description,
        "price": product.price,
        "rating": product.rating,
      };
      final record = await pb.collection('products').create(body: body);
    }
  }
}
