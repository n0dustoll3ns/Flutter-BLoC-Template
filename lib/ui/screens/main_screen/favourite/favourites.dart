import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/favourite/components/item_card.dart';

import '../../../../app/routes/constants.dart';
import '../../../../features/favourite/favourite_products_bloc.dart';
import '../../../components/menu_button.dart';

class Favourites extends StatelessWidget {
  const Favourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(mainPageSections[2]),
          actions: [
            IconButton(
                onPressed: () => context.read<FavouriteBloc>().add(DislikeAll()),
                icon: const Icon(Icons.cleaning_services_rounded)),
            const MenuButton(),
          ],
        ),
        body: BlocBuilder<FavouriteBloc, FavouriteState>(builder: (context, state) {
          return ListView(children: [
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
        }));
  }
}
