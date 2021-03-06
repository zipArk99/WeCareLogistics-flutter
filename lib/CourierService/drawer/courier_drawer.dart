import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/screens/courier_homepage.dart';
import 'package:wecare_logistics/CourierService/screens/courier_myprofile.dart';
import 'package:wecare_logistics/CourierService/screens/courier_yourorder.dart';
import 'package:wecare_logistics/CourierService/screens/courierservise_registration_screen.dart';
import 'package:wecare_logistics/models/user.dart';

class CourierDrawer extends StatelessWidget {
  Widget getListTile({
    required BuildContext contx,
    required IconData icon,
    required String drawerTitle,
    String navigationString = "",
  }) {
    return Container(
      child: ListTile(
        onTap: () {
          if (navigationString != "") {
            Navigator.of(contx).pushReplacementNamed(navigationString);
          }
        },
        leading: Icon(
          icon,
          size: 30,
        ),
        title: Text(
          drawerTitle,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
      UserProvider user = Provider.of<UserProvider>(contx);
    return Drawer(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(contx).primaryColor,
                Theme.of(contx).primaryColor,
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Deviprasad Yadav",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "AnjaniCouriers@gmail.com",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          getListTile(
            icon: Icons.home,
            drawerTitle: "Home",
            contx: contx,
            navigationString:
                CourierServiceHomePage.courierServiceHomePageRoute,
          ),
          getListTile(
            icon: Icons.shopping_cart_outlined,
            drawerTitle: "Your Orders",
            contx: contx,
            navigationString: CourierYourOrder.courierYourOrderRoute,
          ),
          getListTile(
            icon: Icons.account_circle,
            drawerTitle: "User Profile",
            contx: contx,
            navigationString: CourierMyProfile.courierMyProfileRoute,
          ),
          getListTile(
            icon: Icons.app_registration,
            drawerTitle: "User Registration",
            contx: contx,
            navigationString:
                CourierRegistrationScreen.courierRegistrationScreenRoute,
          ),
          getListTile(
            icon: Icons.settings,
            drawerTitle: "Settings",
            contx: contx,
          ),
          getListTile(
            icon: Icons.qr_code_scanner_rounded,
            drawerTitle: "Scan QR",
            contx: contx,
          ),
                 Padding(
            padding: const EdgeInsets.all(5),
            child: TextButton(
              onPressed: () {
                user.logOutUser(contx);
              },
              style: ButtonStyle(
                padding:
                    MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      color: Theme.of(contx).errorColor,
                    ),
                  ),
                ),
              ),
              child: Text(
                "LogOut",
                style: TextStyle(
                  color: Theme.of(contx).errorColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
