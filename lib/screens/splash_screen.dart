import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

class SplashScreen extends StatelessWidget {
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
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 70,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(contx)
                      .pushReplacementNamed(SignUpScreen.signUpScreenRoute);
                },
                child: Text(
                  "NEXT",
                ),
              ),
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