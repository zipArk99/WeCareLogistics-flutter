import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/order_model.dart';

import 'package:wecare_logistics/sender/widgets/order_widget.dart';

import 'create_order_screen.dart';

class SenderHomePageScreen extends StatefulWidget {
  static const String senderHomePageScreenRoute = "/SenderHomePageScreenRoute";

  @override
  _SenderHomePageScreenState createState() => _SenderHomePageScreenState();
}

class _SenderHomePageScreenState extends State<SenderHomePageScreen> {
  bool init = true;
  bool isLoading = false;
  @override
  Widget createHomePageContainer() {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        height: 125,
        width: 100,
        color: Colors.amber,
      ),
    );
  }

  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<OrdersProvider>(context).fetchOrder(true);
    init = false;
    setState(() {
      isLoading = false;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    var order = Provider.of<OrdersProvider>(contx);
    print("order length::" + order.getOrderList().length.toString());
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              createHomePageContainer(),
              createHomePageContainer(),
            ],
          ),
          Row(
            children: [
              createHomePageContainer(),
              createHomePageContainer(),
            ],
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
              : isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ListView.builder(
                          itemBuilder: (contx, index) {
                            return OrdersWidget(
                              published: order.getOrderList()[index].published,
                              key: Key(order.getOrderList()[index].orderId),
                              id: order.getOrderList()[index].orderId,
                              orderTitle:
                                  order.getOrderList()[index].orderTitle,
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
