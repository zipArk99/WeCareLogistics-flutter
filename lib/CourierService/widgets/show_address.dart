import 'package:flutter/material.dart';

class ShowAddress extends StatefulWidget {
  String pickUpLocation;
  String dropLocation;

  ShowAddress({
    required this.pickUpLocation,
    required this.dropLocation,
  });
  @override
  State<StatefulWidget> createState() {
    return ShowAddressState();
  }
}

class ShowAddressState extends State<ShowAddress> {
  bool isDown = false;
  @override
  Widget build(BuildContext contx) {
    return Container(
      color: Colors.teal.shade300,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.location_on_outlined,
              size: 35,
              color: Colors.black,
            ),
            title: Text(
              "${widget.pickUpLocation} --> ${widget.dropLocation}",
              style: TextStyle(fontFamily: 'Poppins', fontSize: 12),
            ),
            trailing: Material(
              color: Colors.teal.shade300,
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isDown = !isDown;
                  });
                },
                icon: isDown
                    ? Icon(
                        Icons.arrow_circle_up,
                        color: Colors.black,
                        size: 30,
                      )
                    : Icon(
                        Icons.arrow_circle_down,
                        color: Colors.black,
                        size: 30,
                      ),
              ),
            ),
          ),
          if (isDown)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ListTile(
                leading: Icon(Icons.arrow_back_ios),
                subtitle: Text(
                  "Shaurya Kaj \n H/7 Sukrutu falts b/h Manekbuag hall",
                  style: TextStyle(fontSize: 12),
                ),
                title: Text(
                  "PickUp Location:",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          if (isDown)
            SizedBox(
              height: 10,
            ),
          if (isDown)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: ListTile(
                leading: Icon(Icons.arrow_forward_ios),
                subtitle: Text(
                    "Shaun Shah \n Mumbai borivali west near powder gally",
                    style: TextStyle(fontSize: 12)),
                title: Text(
                  "Drop Location:",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
