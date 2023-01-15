// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc_template/app/routes/constants.dart';
// import 'package:flutter_bloc_template/ui/styles/constants.dart';

// import 'quick_filter.dart';

// class QuickFilters extends StatefulWidget {
//   final Function(String) onFilterChange;
//   const QuickFilters({super.key, required this.onFilterChange});

//   @override
//   State<QuickFilters> createState() => _QuickFiltersState();
// }

// class _QuickFiltersState extends State<QuickFilters> {
//   String filter = '';
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 55,
//       child: ListView.separated(
//         separatorBuilder: (context, index) => const SizedBox(width: kDefaultPadding),
//         padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
//         scrollDirection: Axis.horizontal,
//         itemCount: quickFilters.length,
//         itemBuilder: (context, index) => QuickFilter(
//           name: quickFilters[index],
//           onTap: () {
//             setState(() {
//               filter = quickFilters[index];
//               widget.onFilterChange(quickFilters[index]);
//             });
//           },
//           isSelected: filter == quickFilters[index],
//         ),
//       ),
//     );
//   }
// }
