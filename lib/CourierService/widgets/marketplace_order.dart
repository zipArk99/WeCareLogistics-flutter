import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/place_bid.dart';
import 'package:wecare_logistics/models/bids_model.dart';

import 'package:wecare_logistics/screens/order_detail_screen.dart';

class MarketPlaceOrderWidget extends StatefulWidget {
  String orderId;
  bool isBided;

  MarketPlaceOrderWidget({required this.orderId, required this.isBided});

  @override
  _MarketPlaceOrderWidgetState createState() => _MarketPlaceOrderWidgetState();
}

class _MarketPlaceOrderWidgetState extends State<MarketPlaceOrderWidget> {
  var isLoading = false;
  TextStyle standarFont() {
    return TextStyle(
      fontSize: 11,
    );
  }

  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<BidsProvider>(context, listen: false)
        .fetchOrderBids(widget.orderId);
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    var order = Provider.of<BidsProvider>(contx, listen: false)
        .getSingleOrder(widget.orderId);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 20),
      width: double.infinity,
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {
            Navigator.of(contx).pushNamed(
                OrderDetailScreen.OrderDetailScreenRoute,
                arguments: {
                  'orderId': widget.orderId,
                  'isCourierService': true,
                });
          },
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.amber,
                leading: Container(
                    child: Icon(
                  Icons.location_on,
                  size: 35,
                  color: Theme.of(contx).primaryColor,
                )),
                title: Text(
                  "Ahmedabad(GJ) - Rajkot(GJ)",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        "Posted on 30 Dec, 7:17pm",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text("|"),
                    ),
                    Expanded(
                      flex: 6,
                      child: Text(
                        order.expectedDelivery.toString(),
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 23,
                            height: 23,
                            child: Image.asset(
                              'lib/assets/images/box(3).png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            order.orderTitle,
                            style: standarFont(),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            width: 23,
                            height: 23,
                            child: Icon(Icons.monitor_weight_sharp),
                          ),
                          title: Text(
                            order.orderWeight.toString() + "KG",
                            style: standarFont(),
                          ),
                        ),
                        ListTile(
                          leading: Container(
                            width: 28,
                            height: 28,
                            child: Image.asset(
                              'lib/assets/images/cube (1).png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            "${order.orderLendth}(L)*${order.orderBreadth}(B)*${order.orderHeight}(H)",
                            style: standarFont(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$ 200",
                              style: TextStyle(
                                color: Theme.of(contx).primaryColorDark,
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "Least Bid",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Consumer<BidsProvider>(
                          builder: (contx, bid, child) {
                            return Container(
                              height: 50,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 15),
                              child: widget.isBided
                                  ? isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : ElevatedButton.icon(
                                          icon: Icon(
                                              Icons.mode_edit_outline_rounded),
                                          onPressed: () {
                                            BottomSheetWidget(
                                              contx: contx,
                                              orderId: order.orderId,
                                              isEdit: true,
                                            );
                                          },
                                          label: Text("Edit"),
                                        )
                                  : ElevatedButton.icon(
                                      icon: Container(
                                        height: 20,
                                        width: 20,
                                        child: Image.asset(
                                          'lib/assets/images/auction.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onPressed: () {
                                        BottomSheetWidget(
                                          contx: contx,
                                          orderId: order.orderId,
                                        );
                                      },
                                      label: Text("Bid"),
                                    ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                leading: Icon(
                  Icons.account_circle_sharp,
                  size: 50,
                ),
                title: Text(
                  "Ram Puri",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
