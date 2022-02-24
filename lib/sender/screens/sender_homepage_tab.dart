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

  Widget createHomePageContainer(String title, int value) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Card(
          color: Colors.amber,
          elevation: 10,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "$value",
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  child: Text(
                    "$title\nOrders",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
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
              createHomePageContainer("Saved", 5),
              createHomePageContainer("Published", 8),
            ],
          ),
          Row(
            children: [
              createHomePageContainer("Active", 7),
              createHomePageContainer("Completed", 10),
            ],
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Saved Orders " + "( ${order.getOrderList().length} )",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
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
                        width: 100,
                        height: 100,
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
                              count: index,
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
