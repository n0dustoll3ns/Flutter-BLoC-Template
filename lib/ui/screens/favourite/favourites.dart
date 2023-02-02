import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/favourite/components/item_card.dart';

import '../../../app/routes/constants.dart';
import '../../../features/favourite/favourite_categories.dart';
import '../../../features/favourite/favourite_products_bloc.dart';
import '../../components/menu_button.dart';
import 'components/category_card.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[3]),
          actions: [
            IconButton(
                onPressed: () => context.read<FavouriteBloc>().add(DislikeAll()),
                icon: const Icon(Icons.cleaning_services_rounded)),
            const MenuButton(),
          ],
        ),
        body: ListView(
          children: [
            BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
              return Column(children: [
                ...List.generate(state.items.length, (index) {
                  var item = state.items.toList()[index];
                  return Dismissible(
                    background: Container(color: Colors.redAccent),
                    onDismissed: (DismissDirection direction) =>
                        context.read<FavouriteBloc>().add(DislikeItem(item: item)),
                    key: ValueKey(index),
                    child: ItemCard(item: item),
                  );
                }),
              ]);
            }),
            BlocBuilder<FavouriteCategoriesBloc, FavouriteCategoriesState>(builder: (context, state) {
              return Column(children: [
                ...List.generate(state.categories.length, (index) {
                  var item = state.categories.toList()[index];
                  return Dismissible(
                    background: Container(color: Colors.redAccent),
                    onDismissed: (DismissDirection direction) =>
                        context.read<FavouriteCategoriesBloc>().add(DislikeCategory(item: item)),
                    key: ValueKey(index),
                    child: FavourteCategoryCard(category: item),
                  );
                }),
              ]);
            }),
          ],
        ));
  }
}
