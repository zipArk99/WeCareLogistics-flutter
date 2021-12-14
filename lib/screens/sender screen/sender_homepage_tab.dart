import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/screens/sender%20screen/create_order_screen.dart';
import 'package:wecare_logistics/widgets/order_widget.dart';

class SenderHomePageScreen extends StatelessWidget {
  static const String senderHomePageScreenRoute = "/SenderHomePageScreenRoute";
  @override
  Widget build(BuildContext contx) {
    var order = Provider.of<OrdersProvider>(contx);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            height: 200,
            child: Card(
              child: Center(
                child: Text("Picture"),
              ),
            ),
          ),
          Text("Orders"),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: ListView.builder(
                itemBuilder: (contx, index) {
                  return OrdersWidget(
                    orderTitle: order.getOrderList()[index].orderTitle,
                    pickUpLocation: order.getOrderList()[index].pickUpLocation,
                    dropLocation: order.getOrderList()[index].dropLocation,
                  );
                },
                itemCount: order.getOrderList().length,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(contx)
              .pushNamed(CreateOrderScreen.createOrderScreenRoute);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
