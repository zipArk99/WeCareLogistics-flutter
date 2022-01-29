import 'package:flutter/material.dart';
import 'package:wecare_logistics/CourierService/drawer/courier_drawer.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_appbar.dart';

class CourierRegistrationScreen extends StatefulWidget {
  static const String courierRegistrationScreenRoute =
      "/CourierRegistrationScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return CourierRegistrationScreenState();
  }
}

class CourierRegistrationScreenState extends State<CourierRegistrationScreen> {
  Widget createTextFormField({required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      child: TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      drawer: CourierDrawer(),
      appBar: PreferredSize(
        child: CourierAppBar(
          barTitle: "Registration",
        ),
        preferredSize: Size.fromHeight(80),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: createTextFormField(label: "Company name"),
                    ),
                    Expanded(
                      flex: 4,
                      child: createTextFormField(label: "Total branch"),
                    )
                  ],
                ),
                createTextFormField(label: "Business experience"),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
                  child: TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: createTextFormField(label: "City"),
                    ),
                    Expanded(
                      flex: 4,
                      child: createTextFormField(label: "Pincode"),
                    )
                  ],
                ),
                createTextFormField(label: "Company pan no"),
                createTextFormField(label: "GSTIN no"),
                createTextFormField(label: "Aadhar no"),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(horizontal: 13),
        width: double.infinity,
        height: 40,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.green,
          ),
          onPressed: () {},
          child: Text("Submit"),
        ),
      ),
    );
  }
}
