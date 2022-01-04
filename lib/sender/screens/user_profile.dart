import 'package:flutter/material.dart';
import 'package:wecare_logistics/sender/drawer/drawer_screen.dart';

class UserProfile extends StatefulWidget {
  static const String userProfileRoute = "/UserProfileRoute";
  @override
  State<StatefulWidget> createState() {
    return UserProfileState();
  }
}

class UserProfileState extends State<UserProfile> {
  Widget createTextFormField(String title) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        enabled: false,
        initialValue: "Shaurya Kaj",
        decoration: InputDecoration(labelText: title),
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Theme.of(contx).primaryColor, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.4],
          ),
        ),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 180,
                left: 10,
                right: 10,
              ),
              child: Card(
                child: Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "PROFILE",
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        /*  Container(
                          alignment: Alignment.topRight,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.edit_outlined,
                                  size: 40,
                                ),
                              ),
                              Text("EDIT"),
                            ],
                          ),
                        ), */
                        createTextFormField("Name"),
                        createTextFormField("Email"),
                        createTextFormField("PhoneNo"),
                        createTextFormField("Address")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            /*         Positioned(
              top: 135.00,
              left: 165,
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 40,
              ),
            ), */
            Container(
              margin: EdgeInsets.only(top: 40),
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                child: Image.asset(
                  'lib/assets/images/user.png',
                  fit: BoxFit.cover,
                ),
                radius: 60,
              ),
            )
          ],
        ),
      ),
    );
  }
}
