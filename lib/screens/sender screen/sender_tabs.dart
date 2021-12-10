import 'package:flutter/material.dart';
import 'package:wecare_logistics/drawer/drawer_screen.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_homepage_tab.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_publishedOrder_tab.dart';

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
          child: AppBar(
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(40),
                bottomLeft: Radius.circular(40),
              ),
            ),
            title: Text("WeCare"),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.notifications_on_sharp)),
              )
            ],
          ),
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
