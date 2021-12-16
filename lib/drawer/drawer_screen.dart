import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  Widget getListTile(IconData icon, String drawerTitle) {
    return Container(
      child: ListTile(
        onTap: () {},
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
    return Drawer(
      child: SingleChildScrollView(
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
                    "Shaurya P. Kaj",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "kajiwalaShaurya29@gmail.com",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w100,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            getListTile(Icons.account_circle, "User Profile"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.shopping_cart_outlined, "Your Orders"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.settings, "Settings"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.notifications, "Notification"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.help_center, "Help Center"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.phone, "Contact Us"),
            Divider(
              thickness: 1,
            ),
            getListTile(Icons.contact_mail_sharp, "Settings"),
            Divider(
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextButton(
                onPressed: () {},
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
      ),
    );
  }
}
