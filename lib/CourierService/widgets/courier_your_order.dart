import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/activate_yourorder.dart';
import 'package:wecare_logistics/CourierService/widgets/show_address.dart';
import 'package:wecare_logistics/models/your_order.dart';

class CourierYourOrder extends StatelessWidget {
  final double orderWeight;
  final double orderLendth;
  final double orderBreadth;
  final double orderHeight;
  final String pickUpLocation;
  final String dropLocation;
  final String orderStatus;
  final String yourOrderId;

  CourierYourOrder({
    required this.orderWeight,
    required this.orderLendth,
    required this.orderBreadth,
    required this.orderHeight,
    required this.pickUpLocation,
    required this.dropLocation,
    required this.orderStatus,
    required this.yourOrderId,
  });
  @override
  Widget build(BuildContext contx) {
  
    return Container(
      color: Colors.grey.shade200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          Container(
            color: orderStatus == 'Inactive'
                ? Theme.of(contx).errorColor
                : Colors.green,
            child: ListTile(
              leading: Icon(
                Icons.cached_sharp,
                size: 35,
                color: Colors.black,
              ),
              subtitle: Text(orderStatus),
              title: Text(
                "Status ",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
              ),
              trailing: orderStatus == 'Inactive'
                  ? ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                      ),
                      onPressed: () {
                        ShowActivateDialogBox(
                            contx: contx, yourOrderId: yourOrderId);
                      },
                      icon: Icon(Icons.check),
                      label: Text("Select Pickup"),
                    )
                  : null,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.account_box_rounded,
              size: 35,
              color: Colors.black,
            ),
            title: Text(
              "Shaurya Kajiwala ",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.monitor_weight_sharp,
              color: Colors.black,
              size: 35,
            ),
            title: Text(
              "$orderWeight" + "KG",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
          ),
          ListTile(
            leading: Container(
              width: 35,
              height: 35,
              child: Image.asset(
                'lib/assets/images/cube (1).png',
                color: Colors.black,
                fit: BoxFit.cover,
              ),
            ),
            title: Text("$orderLendth(L)*$orderBreadth(B)*$orderHeight(H)",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
          ),
          ShowAddress(
            dropLocation: dropLocation,
            pickUpLocation: pickUpLocation,
          ),
        ],
      ),
    );
  }
}
