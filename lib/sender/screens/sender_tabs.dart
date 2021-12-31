import 'package:flutter/material.dart';
import 'package:wecare_logistics/sender/drawer/drawer_screen.dart';

import 'package:wecare_logistics/sender/screens/sender_homepage_tab.dart';
import 'package:wecare_logistics/sender/screens/sender_publishedOrder_tab.dart';
import 'package:wecare_logistics/sender/widgets/sender_appbar.dart';

class SenderTabs extends StatefulWidget {
  static const senderTabsRoute = "/SenderTabsRoute";

  @override
  _SenderTabsState createState() => _SenderTabsState();
}

class _SenderTabsState extends State<SenderTabs> {
  var _tabs = [
    SenderHomePageScreen(),
    PublishedOrderTab(),
  ];

  var _selectedIndex = 0;

  void onTabTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext contx) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: DrawerScreen(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: SenderAppBar(
              barTitle: "WeCare", color: Theme.of(contx).primaryColor),
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black,
          iconSize: 35,
          selectedFontSize: 13,
          unselectedFontSize: 10,
          backgroundColor: Theme.of(contx).primaryColor,
          currentIndex: _selectedIndex,
          onTap: onTabTap,
          items: [
            BottomNavigationBarItem(
              label: "Saved Orders",
              icon: Icon(Icons.assignment_turned_in_rounded),
            ),
            BottomNavigationBarItem(
              label: "Published Orders",
              icon: Icon(Icons.assignment_turned_in_rounded),
            )
          ],
        ),
      ),
    );
  }
}
