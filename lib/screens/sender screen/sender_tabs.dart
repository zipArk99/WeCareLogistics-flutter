import 'package:flutter/material.dart';
import 'package:wecare_logistics/drawer/drawer_screen.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_homepage_tab.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_publishedOrder_tab.dart';

class SenderTabs extends StatelessWidget {
  static const senderTabsRoute = "/SenderTabsRoute";
  @override
  Widget build(BuildContext contx) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerScreen(),
        appBar: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
          ),
          title: Text("WeCare"),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.values[1],
            tabs: [
              Tab(child: Text("Saved")),
              Tab(child: Text("Published")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SenderHomePageScreen(),
            PublishedOrderTab(),
          ],
        ),
      ),
    );
  }
}
