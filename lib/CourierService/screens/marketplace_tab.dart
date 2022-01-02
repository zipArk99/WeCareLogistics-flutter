import 'package:flutter/material.dart';
import 'package:wecare_logistics/CourierService/screens/courierservise_registration_screen.dart';
import 'package:wecare_logistics/CourierService/widgets/marketplace_order.dart';

class MarketPlaceTab extends StatelessWidget {
  TextStyle standarFont() {
    return TextStyle(
      fontSize: 11,
    );
  }

/* #919191 */
  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (contx, index) {
          return MarketPlaceOrderWidget();
        },
        itemCount: 1,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(contx).pushNamed(
              CourierRegistrationScreen.courierRegistrationScreenRoute);
        },
        child: Icon(Icons.app_registration),
      ),
    );
  }
}
