import 'package:flutter/material.dart';

class YourOrderWidget extends StatelessWidget {
  final String yourOrderId;
  final DateTime yourOrderDate;
  final String reciverName;
  final String productTitle;
  final String dropLocation;
  final String courierServiceName;
  final double price;

  YourOrderWidget({
    required this.yourOrderId,
    required this.yourOrderDate,
    required this.reciverName,
    required this.productTitle,
    required this.dropLocation,
    required this.courierServiceName,
    required this.price,
  });

  void openOptionsDialogBox(BuildContext contx) {
    showDialog(
      context: contx,
      builder: (contx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                dialogOptions("Download Label"),
                dialogOptions("Download Invoice"),
                dialogOptions("Order Details"),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget dialogOptions(String title) {
    return Flexible(
      flex: 1,
      fit: FlexFit.tight,
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    var reciverNameArray = reciverName.split("");
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      child: Card(
        elevation: 10,
        child: InkWell(
          onTap: () {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Order ID: $yourOrderId",
                    ),
                    IconButton(
                      iconSize: 40,
                      onPressed: () {
                        openOptionsDialogBox(contx);
                      },
                      icon: Icon(Icons.more_horiz),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text("Order Created On:" + " 20 Oct,2020"),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Card(
                  color: Colors.white70,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.amber.shade300,
                          radius: 20,
                          child: Text(
                            "${reciverNameArray[0].toUpperCase()}",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "$reciverName",
                          style: TextStyle(fontSize: 12),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.black,
                        ),
                        Text(
                          "$productTitle",
                          style: TextStyle(fontSize: 12),
                        ),
                        Container(
                          height: 20,
                          width: 2,
                          color: Colors.black,
                        ),
                        Text(
                          "$dropLocation",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                tileColor: Colors.amber.shade300,
                leading: CircleAvatar(
                  radius: 25,
                  child: Image.network(
                    'https://play-lh.googleusercontent.com/YtXTsa-6SaaMl02-OUo8iRztlX5Thu4aCLavunIV1M5hm9y4ySTPpMjpY44fL4ayz7Se',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  "$courierServiceName",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(
                  "paid:" + " Rs$price",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Track Order",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
