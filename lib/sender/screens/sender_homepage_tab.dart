import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/order_model.dart';

import 'package:wecare_logistics/sender/widgets/order_widget.dart';

import 'create_order_screen.dart';

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
          order.getOrderList().isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  child: Column(
                    children: [
                      Text(
                        "No Orders!",
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(contx).errorColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 150,
                        height: 150,
                        child: Image.asset(
                          'lib/assets/images/waiting.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      color: Colors.white60,
                      child: ListView.builder(
                        itemBuilder: (contx, index) {
                          return OrdersWidget(
                            key: Key(order.getOrderList()[index].orderId),
                            id: order.getOrderList()[index].orderId,
                            orderTitle: order.getOrderList()[index].orderTitle,
                            pickUpLocation:
                                order.getOrderList()[index].pickUpLocation,
                            dropLocation:
                                order.getOrderList()[index].dropLocation,
                          );
                        },
                        itemCount: order.getOrderList().length,
                      ),
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
   /*       */