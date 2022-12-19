// import 'package:flutter/material.dart';

// import '../../../../features/order/model.dart';

// class TotalSection extends StatelessWidget {
//   final Order order;
//   const TotalSection({super.key, required this.order});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Total',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               Text(
//                 '\$${order.totalCost.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Items, ${order.items.length} pieces',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
//               ),
//               Text(
//                 '\$${order.totalCost.toStringAsFixed(2)}',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Promo-code',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
//               ),
//               Text(
//                 '0',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'data',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
//               ),
//               Text(
//                 'data',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'data',
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey),
//               ),
//               Text(
//                 'data',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
