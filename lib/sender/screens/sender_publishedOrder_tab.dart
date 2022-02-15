import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/sender/widgets/order_widget.dart';

class PublishedOrderTab extends StatelessWidget {
  static const String publishedOrderTabRoute = "/PublishedOrderTabRoute";
  @override
  Widget build(BuildContext contx) {
    var order = Provider.of<OrdersProvider>(contx);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  itemBuilder: (contx, index) {
                    return OrdersWidget(
                      count: index,
                      published: order.getPublishedOrderList()[index].published,
                      key: Key(order.getPublishedOrderList()[index].orderId),
                      id: order.getPublishedOrderList()[index].orderId,
                      orderTitle:
                          order.getPublishedOrderList()[index].orderTitle,
                      pickUpLocation:
                          order.getPublishedOrderList()[index].pickUpLocation,
                      dropLocation:
                          order.getPublishedOrderList()[index].dropLocation,
                    );
                  },
                  itemCount: order.getPublishedOrderList().length,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
