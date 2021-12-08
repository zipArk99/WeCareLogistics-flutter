import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/login_screen.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const myAppRoute = "/MyAppRoute";
  Widget build(BuildContext contx) {
    return MaterialApp(
      title: "WeCare",
      theme: ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
      home: LoginPageScreen(),
      initialRoute: "/",
      routes: {
        myAppRoute: (contx) => MyApp(),
        SignUpScreen.signUpScreenRoute: (contx) => SignUpScreen(),
        LoginPageScreen.loginPageScreenRoute: (contx) => LoginPageScreen(),
      },
    );
  }
}
