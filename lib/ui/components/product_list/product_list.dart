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
            ElevatedButton(onPressed: () => attachToCategory(context), child: Text('Attach to category')),
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

  Future<void> attachToCategory(BuildContext context) async {
    var bloc = context.read<CatalogPageProductsBloc>();
    AdminAuth adminAuth = AdminAuth();
    var authState = context.read<AuthenticationBloc>().state;
    if (authState is AuthenticationAuthenticated) {
      adminAuth = authState.authData;
    }
    final pb = PocketBase('https://pocketbase.dancheg97.ru',
        authStore: AuthStore()..save(adminAuth.token, adminAuth.admin));

    List<RecordModel> products = [];
    for (var product in bloc.state.items) {
      final record = await pb.collection('products').getFirstListItem(
            'name="${product.name}"',
          );

      products.add(record);
    }

    final cbody = <String, dynamic>{"name": category!.name, "products": products.map((e) => e.id).toList()};

    final update = await pb.collection('categories').update(category!.id, body: cbody);
  }
}
