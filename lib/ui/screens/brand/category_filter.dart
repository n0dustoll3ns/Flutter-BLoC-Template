import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_template/app/routes/constants.dart';
import 'package:flutter_bloc_template/ui/styles/constants.dart';

import '../catalog/components/quick_filter.dart';

class CategoryFilters extends StatefulWidget {
  final Function(String) onFilterChange;
  final List<String> items;
  const CategoryFilters({super.key, required this.onFilterChange, required this.items});

  @override
  State<CategoryFilters> createState() => _CategoryFiltersState();
}

class _CategoryFiltersState extends State<CategoryFilters> {
  String filter = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width/7,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: kDefaultPadding),
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) => QuickFilter(
          name: widget.items[index],
          onTap: () {
            setState(() {
              filter = widget.items[index];
              widget.onFilterChange(quickFilters[index]);
            });
          },
          isSelected: filter == widget.items[index],
        ),
      ),
    );
  }
}
