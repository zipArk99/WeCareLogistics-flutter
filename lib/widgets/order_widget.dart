import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/screens/sender%20screen/order_detail_screen.dart';

class OrdersWidget extends StatelessWidget {
  final String orderId = Random().nextInt(1000).toString();
  final String id;
  final String orderTitle;
  final String pickUpLocation;
  final String dropLocation;

  OrdersWidget(
      {required this.id,
      required this.orderTitle,
      required this.pickUpLocation,
      required this.dropLocation});
  @override
  Widget build(BuildContext contx) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          onTap: () {
            Navigator.of(contx).pushNamed(
              OrderDetailScreen.OrderDetailScreenRoute,
              arguments: id,
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text("#" + orderId),
          ),
          title: Text(orderTitle),
          subtitle: Text(
            "$pickUpLocation-->$dropLocation",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              Provider.of<OrdersProvider>(contx, listen: false).deleteOrder(id);
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
