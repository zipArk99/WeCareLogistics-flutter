import 'package:flutter/material.dart';

class CreateOrderScreen extends StatefulWidget {
  static const String createOrderScreenRoute = "/CreateOrderScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return CreateOrderScreenState();
  }
}

class CreateOrderScreenState extends State<CreateOrderScreen> {
  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          title: Text(
            "Create Shipment",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Details",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "PickUpLocation"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Reciver Name"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Drop Location"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Delivery PinCode"),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Order Details",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "L"),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "B"),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "H"),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Weight(kg)"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Product Title"),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Product Category"),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Prd.price"),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(labelText: "Qyt"),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("="),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(labelText: "Total"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: Text("No delivery date selected "),
                        trailing: TextButton(
                          onPressed: () {},
                          child: Text("Select Date"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("Create Order"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
