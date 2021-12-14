import 'dart:math';

import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  final String orderId = "#12e";
  final String orderTitle;
  final String pickUpLocation;
  final String dropLocation;

  OrdersWidget(
      {required this.orderTitle,
      required this.pickUpLocation,
      required this.dropLocation});
  @override
  Widget build(BuildContext contx) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text("#12e"),
          ),
          title: Text(orderTitle),
          subtitle: Text(
            "$pickUpLocation-->$dropLocation",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
