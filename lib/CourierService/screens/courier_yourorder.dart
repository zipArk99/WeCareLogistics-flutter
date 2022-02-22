import 'package:flutter/material.dart';
import 'package:wecare_logistics/CourierService/drawer/courier_drawer.dart';
import 'package:wecare_logistics/CourierService/screens/activeorder_tab.dart';
import 'package:wecare_logistics/CourierService/screens/completedorder_tab.dart';

class CourierYourOrder extends StatelessWidget {
  static const String courierYourOrderRoute = "/CourierYourOrderRoute";
  @override
  Widget build(BuildContext contx) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: CourierDrawer(),
        appBar: AppBar(
          title: Text("Your Order"),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text("Active"),
              ),
              Tab(
                child: Text("Completed"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CourierActiveOrderTab(),
            CourierCompletedOrderTab(),
          ],
        ),
      ),
    );
  }
}
