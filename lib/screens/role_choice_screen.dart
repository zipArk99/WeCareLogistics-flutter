import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/screens/courier_homepage.dart';
import 'package:wecare_logistics/models/user.dart';

import 'package:wecare_logistics/sender/screens/sender_tabs.dart';

class RoleChoiceScreen extends StatefulWidget {
  static const String roleChoiceScreeRoute = "/RoleChoiceScreenRoute";

  @override
  _RoleChoiceScreenState createState() => _RoleChoiceScreenState();
}

class _RoleChoiceScreenState extends State<RoleChoiceScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext contx) {
    var user = Provider.of<UserProvider>(contx, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("User Role"),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
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
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await user.addUserRole("sender");
                        Navigator.of(contx)
                            .pushReplacementNamed(SenderTabs.senderTabsRoute);
                        setState(() {
                          isLoading = false;
                        });
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
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        await user.addUserRole("courierService");
                        Navigator.of(contx).pushNamed(
                            CourierServiceHomePage.courierServiceHomePageRoute);
                        setState(() {
                          isLoading = false;
                        });
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
