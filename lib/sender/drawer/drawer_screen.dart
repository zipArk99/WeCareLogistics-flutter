import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/sender/screens/send_yourorder_tab.dart';
import 'package:wecare_logistics/sender/screens/sender_tabs.dart';
import 'package:wecare_logistics/sender/screens/user_profile.dart';

class DrawerScreen extends StatelessWidget {
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
              child: Consumer<UserProvider>(
                builder: (contx, user, child) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${user.userFirstName}  ${user.userLastName}",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        user.userEmail,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            getListTile(
              icon: Icons.account_circle,
              drawerTitle: "User Profile",
              contx: contx,
              navigationString: UserProfile.userProfileRoute,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.save_rounded,
              drawerTitle: "Saved Orders",
              contx: contx,
              navigationString: SenderTabs.senderTabsRoute,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.shopping_cart_outlined,
              drawerTitle: "Your Orders",
              contx: contx,
              navigationString: SenderYourOrderTabs.senderYourOrderTabsRoute,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.settings,
              drawerTitle: "Settings",
              contx: contx,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.notifications,
              drawerTitle: "Notification",
              contx: contx,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.help_center,
              drawerTitle: "Help Center",
              contx: contx,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.phone,
              drawerTitle: "Contact Us",
              contx: contx,
            ),
            Divider(
              thickness: 1,
            ),
            getListTile(
              icon: Icons.contact_mail_sharp,
              drawerTitle: "Settings",
              contx: contx,
            ),
            Divider(
              thickness: 1,
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
      ),
    );
  }
}
