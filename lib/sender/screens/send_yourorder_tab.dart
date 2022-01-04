import 'package:flutter/material.dart';
import 'package:wecare_logistics/sender/drawer/drawer_screen.dart';
import 'package:wecare_logistics/sender/screens/your_active_orders.dart';
import 'package:wecare_logistics/sender/screens/your_completed_orders.dart';

class SenderYourOrderTabs extends StatelessWidget {
  static const String senderYourOrderTabsRoute = "/SenderYourOrderTabRoute";
  @override
  Widget build(BuildContext contx) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerScreen(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            title: Text("Your Order"),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Text(
                    "Active Orders",
                    style: TextStyle(fontSize: 12),
                  ),
                  icon: Icon(Icons.one_k_plus_outlined),
                ),
                Tab(
                  icon: Icon(Icons.access_alarm_sharp),
                  child: Text(
                    "Completed Orders",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            YourActiveOrders(),
            YourCompletedOrders(),
          ],
        ),
      ),
    );
  }
}
