import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/bids_model.dart';

import 'package:wecare_logistics/models/order_model.dart';

import 'package:wecare_logistics/screens/order_detail_screen.dart';

class OrdersWidget extends StatefulWidget {
  final String id;
  final String orderTitle;
  final String pickUpLocation;
  final String dropLocation;
  final bool published;

  OrdersWidget(
      {required Key key,
      required this.id,
      required this.orderTitle,
      required this.pickUpLocation,
      required this.dropLocation,
      required this.published})
      : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  final String orderId = Random().nextInt(1000).toString();

  @override
  void didChangeDependencies() {
    if (widget.published) {
      Provider.of<OrdersProvider>(context).fetchOrderBids(widget.id);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          onTap: () {
            /* ChangeNotifierProvider(create: (contx) => BidsProvider()); */
            Navigator.of(contx).pushNamed(
              OrderDetailScreen.OrderDetailScreenRoute,
              arguments: {
                'orderId': widget.id,
                'isCourierService': false,
              },
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text("#" + orderId),
          ),
          title: Text(widget.orderTitle),
          subtitle: Text(
            "${widget.pickUpLocation}-->${widget.dropLocation}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              Provider.of<OrdersProvider>(contx, listen: false)
                  .deleteOrder(widget.id);
            },
            icon: Icon(
              Icons.delete,
              size: 30,
              color: Theme.of(contx).errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
