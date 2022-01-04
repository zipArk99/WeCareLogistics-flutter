import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/drawer/courier_drawer.dart';
import 'package:wecare_logistics/CourierService/screens/marketplace_tab.dart';
import 'package:wecare_logistics/CourierService/screens/mybids_tab.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_appbar.dart';
import 'package:wecare_logistics/models/bids_model.dart';

class CourierServiceHomePage extends StatefulWidget {
  static const String courierServiceHomePageRoute =
      "/CourierServiceHomePageRoute";

  @override
  _CourierServiceHomePageState createState() => _CourierServiceHomePageState();
}

class _CourierServiceHomePageState extends State<CourierServiceHomePage> {
  var tabs = [
    {"tab": MarketPlaceTab(), "title": "MarketPlace"},
    {"tab": MyBidsTab(), "title": "MyBids"},
  ];
  var tabIndex = 0;

  void onTabTabs(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      drawer: CourierDrawer(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: CourierAppBar(
            barTitle: tabs[tabIndex]['title'].toString(),
          )),
      body: tabs[tabIndex]['tab'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        unselectedIconTheme: IconThemeData(color: Colors.grey, size: 35),
        selectedIconTheme:
            IconThemeData(color: Theme.of(contx).primaryColor, size: 35),
        onTap: onTabTabs,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop_sharp,
            ),
            label: "MarketPlace",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_travel),
            label: "My Bid",
          ),
        ],
      ),
    );
  }
}
