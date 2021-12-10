import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/login_screen.dart';
import 'package:wecare_logistics/screens/role_choice_screen.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_homepage_tab.dart';
import 'package:wecare_logistics/screens/sender%20screen/sender_tabs.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';
import 'package:wecare_logistics/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const myAppRoute = "/MyAppRoute";
  Widget build(BuildContext contx) {
    return MaterialApp(
      title: "WeCare",
      theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
      home: SplashScreen(),
      initialRoute: "/",
      routes: {
        myAppRoute: (contx) => MyApp(),
        SignUpScreen.signUpScreenRoute: (contx) => SignUpScreen(),
        LoginPageScreen.loginPageScreenRoute: (contx) => LoginPageScreen(),
        RoleChoiceScreen.roleChoiceScreeRoute: (contx) => RoleChoiceScreen(),
        SenderHomePageScreen.senderHomePageScreenRoute: (contx) =>
            SenderHomePageScreen(),
        SenderTabs.senderTabsRoute: (contx) => SenderTabs(),
      },
    );
  }
}
