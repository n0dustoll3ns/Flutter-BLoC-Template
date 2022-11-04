import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/auth_bloc.dart';
import 'package:flutter_bloc_template/features/authentication/authentication.dart';
import 'package:flutter_bloc_template/ui/screens/main_screen/catalog/components/quick_filters.dart';

import '../../../../app/routes/constants.dart';
import 'chapters/chapters_horizontal_view.dart';

class CatalogRoot extends StatelessWidget {
  const CatalogRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mainPageSections[1]),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QuickFilters(onFilterChange: (quickFilter) {}),
            ChaptersHorizontalView(),
          ],
        ),
      ),
    );
  }
}
