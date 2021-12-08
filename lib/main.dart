import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const myAppRoute = "/MyAppRoute";
  Widget build(BuildContext contx) {
    return MaterialApp(
      title: "WeCare",
      theme: ThemeData(primarySwatch: Colors.blue, accentColor: Colors.amber),
      home: SignUpScreen(),
      initialRoute: "/",
      routes: {
        myAppRoute: (contx) => MyApp(),
      },
    );
  }
}
