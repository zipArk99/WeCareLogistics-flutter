import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/sender/widgets/bid_widget.dart';
import 'package:wecare_logistics/sender/widgets/sender_appbar.dart';

class OrderDetailScreen extends StatelessWidget {
  static const String OrderDetailScreenRoute = "/OrderDetailScreenRoute";

  Widget getOrderDetailHeader(
      BuildContext contx, IconData icon, String title, String value) {
    return Flexible(
      fit: FlexFit.tight,
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              icon,
              size: 30,
              color: Theme.of(contx).accentColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$title",
            style: TextStyle(fontSize: 12),
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Theme.of(contx).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    Order order;
    Map<String, dynamic> orderModalRoute =
        ModalRoute.of(contx)!.settings.arguments as Map<String, dynamic>;

    final String orderId = orderModalRoute['orderId'] as String;
    final bool isCourierService = orderModalRoute['isCourierService'] as bool;

    if (isCourierService) {
      order = Provider.of<BidsProvider>(contx, listen: false)
          .getSingleOrder(orderId);
    } else {
      order = Provider.of<OrdersProvider>(contx, listen: false)
          .getSingleOrder(orderId);
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SenderAppBar(
          barTitle: "OrderDetail",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getOrderDetailHeader(
                        contx, Icons.location_on, "Drop", order.dropLocation),
                    getOrderDetailHeader(contx, Icons.monitor_weight_sharp,
                        "Weight", order.orderWeight.toString() + "KG"),
                    getOrderDetailHeader(
                      contx,
                      Icons.calendar_today_outlined,
                      "Delivery Date",
                      DateFormat('dd MMM').format(order.expectedDelivery),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Shipment Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Card(
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Pickup Address  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Text(
                        order.pickUpLocation,
                        style: TextStyle(fontSize: 11),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_location_alt_outlined,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Delivery Address   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.dropLocation,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit_location_alt_outlined,
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Customer Name   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.reciverName,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Customer Phone  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          "9879115776",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Order Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Card(
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Order ID  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Text(
                        order.orderId,
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Order Created on   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.orderCreatedOn.toString(),
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Product Name  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.orderTitle,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Category  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.productCategory,
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Unit Price  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.productPrice.toString(),
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Text(
                        "Quantity  :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.productQuantity.toString(),
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Package Details",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              Card(
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      leading: Text(
                        "Package Weight :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Text(
                        order.orderWeight.toString() + " KG",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Length   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.orderLendth.toString() + " Cm",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Breadth   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.orderBreadth.toString() + " Cm",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      leading: Text(
                        "Height   :",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      title: Container(
                        child: Text(
                          order.orderHeight.toString() + " Cm",
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (order.published != true)
                SizedBox(
                  height: 80,
                ),
              if (order.published == true)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Bids Response",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                  ),
                ),
              if (order.published == true)
                Consumer<BidsProvider>(
                  builder: (contx, bids, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (contx, index) {
                        return BidWidget(
                          courierId: order.bids[index].courierId,
                          order: order,
                          courierName: order.bids[index].courierName,
                          bidId: order.bids[index].bidId,
                          price: order.bids[index].bidPrice,
                          modeOfTransport: order.bids[index].modeOfTransport,
                          bidExpectedDeliveryDate:
                              order.bids[index].bidExpectedDeliveryDate,
                          isCourierService: isCourierService,
                        );
                      },
                      itemCount: order.bids.length,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: order.published == true
          ? null
          : Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              width: double.infinity,
              height: 70,
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<OrdersProvider>(contx, listen: false)
                      .publishOrder(orderId);
                  Navigator.of(contx).pop();
                },
                child: Text("Publish"),
              ),
            ),
    );
  }
}
