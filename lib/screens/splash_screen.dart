import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/WeCare.png"),
            Container(
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
    );
  }
}
