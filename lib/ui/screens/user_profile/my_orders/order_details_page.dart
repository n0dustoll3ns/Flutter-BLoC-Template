import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';
import 'package:flutter_bloc_template/utils/string_capitalize.dart';

import '../../../../app/routes/routes.dart';
import '../../../../features/order/model.dart';
import 'order_info_section.dart';
import 'total_section.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;
  const OrderDetailsPage({super.key, required this.order});

  static Route<dynamic> route(RouteSettings routeSettings) {
    var order = routeSettings.arguments as Order;
    return CupertinoPageRoute(builder: (context) => OrderDetailsPage(order: order));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${order.id}'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 25),
        children: [
          OrderInfo(
            title: 'Order Status',
            child: Text(
              order.status.toString().toCapitalized(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'About Order',
            child: Text(
              '№${order.id} ${order.date.dateAndTime}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'Reciever',
            child: Text(
              '${order.reciever.name}\n+${order.reciever.phoneNumber}\n',
              maxLines: 3,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'Delivery adress',
            child: Text(
              '${order.adress.buildingNumber} ${order.adress.streetName}\n${order.adress.town} ${order.adress.zipCode}',
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'Delivery method',
            child: Text(
              'Delivery by shop',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'Payment method',
            child: Text(
              order.paymentMethod.name,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
            ),
          ),
          OrderInfo(
            title: 'Order list',
            child: SizedBox(
              height: MediaQuery.of(context).size.width / 4,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 28),
                scrollDirection: Axis.horizontal,
                itemCount: order.itemsCounted.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: MediaQuery.of(context).size.width / 44,
                ),
                itemBuilder: (context, index) =>
                    order.itemsCounted.keys.toList()[index].previewImage != null
                ? Image.asset(
                    order.itemsCounted.keys.toList()[index].previewImage!,
                    fit: BoxFit.contain,
                  )
                : const FittedBox(fit: BoxFit.cover, child: Icon(Icons.question_mark_rounded)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 28),
            child: TotalSection(order: order),
          ),
          ElevatedButton(
            onPressed: order.needsPayment
                ? () => Navigator.of(context).pushNamed(Routes.checkoutCompletePage)
                : null,
            style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 32)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width / 28),
              child: Text(order.needsPayment ? 'Pay now' : 'Paid'),
            ),
          ),
        ],
      ),
    );
  }
}
