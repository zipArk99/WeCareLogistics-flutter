import "package:flutter/material.dart";
import 'package:wecare_logistics/CourierService/screens/show_address.dart';

class CourierActiveOrderTab extends StatelessWidget {
  @override
  Widget build(BuildContext contx) {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade200,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
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
                  "30" + "KG",
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
                title: Text("50(L)*50(B)*60(H)",
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 12)),
              ),
              ShowAddress(),
            ],
          ),
        ),
      ],
    );
  }
}
