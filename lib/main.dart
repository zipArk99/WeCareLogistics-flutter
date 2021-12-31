import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecare_logistics/CourierService/screens/courier_homepage.dart';
import 'package:wecare_logistics/CourierService/screens/courierservise_registration_screen.dart';
import 'package:wecare_logistics/screens/login_screen.dart';
import 'package:wecare_logistics/screens/role_choice_screen.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';
import 'package:wecare_logistics/screens/splash_screen.dart';
import 'package:wecare_logistics/sender/models/order_model.dart';
import 'package:wecare_logistics/sender/screens/create_order_screen.dart';
import 'package:wecare_logistics/sender/screens/order_detail_screen.dart';
import 'package:wecare_logistics/sender/screens/send_yourorder_tab.dart';
import 'package:wecare_logistics/sender/screens/sender_homepage_tab.dart';
import 'package:wecare_logistics/sender/screens/sender_tabs.dart';
import 'package:wecare_logistics/sender/screens/user_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const myAppRoute = "/MyAppRoute";
  Widget build(BuildContext contx) {
    return ChangeNotifierProvider(
      create: (contx) => OrdersProvider(),
      child: MaterialApp(
        title: "WeCare",
        theme:
            ThemeData(primarySwatch: Colors.indigo, accentColor: Colors.amber),
        home: SplashScreen(),
        initialRoute: "/",
        routes: {
          //Sender Routes
          myAppRoute: (contx) => MyApp(),
          SignUpScreen.signUpScreenRoute: (contx) => SignUpScreen(),
          LoginPageScreen.loginPageScreenRoute: (contx) => LoginPageScreen(),
          RoleChoiceScreen.roleChoiceScreeRoute: (contx) => RoleChoiceScreen(),
          SenderHomePageScreen.senderHomePageScreenRoute: (contx) =>
              SenderHomePageScreen(),
          SenderTabs.senderTabsRoute: (contx) => SenderTabs(),
          CreateOrderScreen.createOrderScreenRoute: (contx) =>
              CreateOrderScreen(),
          OrderDetailScreen.OrderDetailScreenRoute: (contx) =>
              OrderDetailScreen(),
          SenderYourOrderTabs.senderYourOrderTabsRoute: (contx) =>
              SenderYourOrderTabs(),
          UserProfile.userProfileRoute: (contx) => UserProfile(),
          //-----------------------------------------------------------

          //Courier Service Routes
          CourierServiceHomePage.courierServiceHomePageRoute: (contx) =>
              CourierServiceHomePage(),
          CourierRegistrationScreen.courierRegistrationScreenRoute: (contx) =>
              CourierRegistrationScreen(),
        },
      ),
    );
  }
}
