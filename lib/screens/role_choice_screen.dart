import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wecare_logistics/CourierService/screens/courier_homepage.dart';
import 'package:wecare_logistics/sender/screens/sender_tabs.dart';

class RoleChoiceScreen extends StatelessWidget {
  static const String roleChoiceScreeRoute = "/RoleChoiceScreenRoute";
  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Role"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              height: 110,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green.shade500,
                ),
                onPressed: () {
                  Navigator.of(contx).pushNamed(SenderTabs.senderTabsRoute);
                },
                icon: Icon(Icons.people),
                label: Text(
                  "Sign up as Sender",
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 110,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange.shade800,
                ),
                onPressed: () {
                  Navigator.of(contx).pushNamed(
                      CourierServiceHomePage.courierServiceHomePageRoute);
                },
                icon: Icon(Icons.people),
                label: Text(
                  "Sign up as Courier Service",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
