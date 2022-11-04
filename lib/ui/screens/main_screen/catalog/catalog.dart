import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/categories/catagories.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/components/quick_filters.dart';

import '../../../../app/routes/constants.dart';
import 'chapters/chapters_horizontal_view.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isRoot = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CupertinoTextField(
          prefix: Padding(
            padding: EdgeInsets.all(6.0),
            child: Icon(
              CupertinoIcons.search,
              color: Colors.black45,
            ),
          ),
          decoration:
              BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
        actions: [
          PopupMenuButton<Function>(itemBuilder: (context) {
            return [
              PopupMenuItem<Function>(
                value: () {},
                child: const Text("My Account"),
              ),
              PopupMenuItem<Function>(
                value: () {},
                child: const Text("Settings"),
              ),
              PopupMenuItem<Function>(
                value: () => context.read<AuthenticationBloc>().add(LoggedOut()),
                child: const Text("Logout"),
              ),
            ];
          }, onSelected: (value) {
            value();
          }),
        ],
      ),
      body: ListView.custom(
        childrenDelegate: SliverChildListDelegate(
          [
            QuickFilters(onFilterChange: (quickFilter) {}),
            if (isRoot) const ChaptersHorizontalView(),
            const Categories(),
          ],
        ),
      ),
    );
  }
}
