import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).popAndPushNamed(SignUpScreen.signUpScreenRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/images/truck.gif"),
          fit: BoxFit.contain,
        ),
      ),
      width: double.infinity,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 250,
              height: 250,
              child: Image.asset("lib/assets/images/WeCare.png"),
            ),
            Container(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    ));
  }
}
/* Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("lib/assets/images/truck.gif"),
                      fit: BoxFit.cover)),
              width: double.infinity,
            ), */