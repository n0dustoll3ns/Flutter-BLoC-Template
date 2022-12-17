import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_template/features/order/model.dart';
import 'package:flutter_bloc_template/utils/date_without_time.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  const OrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var items = order.itemsCounted.keys.toList();
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width / 38),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '№ ${order.id} from ${order.date.dateAndTime}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${order.needsPayment ? 'Await of payment' : order.status}',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.grey),
                  ),
                ],
              )),
              IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.arrow_right))
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width / 5,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => SizedBox(child: Image.asset(items[index].img)),
                separatorBuilder: (context, index) => SizedBox(width: MediaQuery.of(context).size.width / 55),
                itemCount: items.length),
          )
        ],
      ),
    );
  }
}
