import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/ui/screens/home_screen/catalog/components/quick_filters.dart';

class CatalogRoot extends StatelessWidget {
  const CatalogRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuickFilters(onFilterChange: (quickFilter) {}),
          QuickFilters(onFilterChange: (quickFilter) {}),
        ],
      ),
    );
  }
}
