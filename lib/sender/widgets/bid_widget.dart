import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/models/transaction_model.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/models/your_order.dart';

class BidWidget extends StatelessWidget {
  final Order order;
  final String bidId;
  final String courierId;
  final String modeOfTransport;
  final String courierName;
  final DateTime bidExpectedDeliveryDate;
  final double price;
  final bool isCourierService;
  BidWidget(
      {required this.order,
      required this.bidId,
      required this.price,
      required this.courierId,
      required this.modeOfTransport,
      required this.courierName,
      required this.bidExpectedDeliveryDate,
      required this.isCourierService});

  Future<void> transactionDialogBox(contx) {
    return showDialog(
        context: contx,
        builder: (contx) {
          return Dialog(
            child: Container(
              height: 250,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Pay The \nAmount",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(contx).primaryColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: price.toString(),
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(contx).primaryColor,
                          fontWeight: FontWeight.w500),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: "\u{20B9} ",
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        var transactionId = '';

                        transactionId = await Provider.of<TransactionProvider>(
                                contx,
                                listen: false)
                            .proccessTransaction(
                          courierName: courierName,
                          courierId: courierId,
                          transactionType: 'payment',
                          bidId: bidId,
                          senderId: order.senderId,
                          transactionAmount: price,
                        );

                        await Provider.of<YourOrderProvider>(contx,
                                listen: false)
                            .addYourOrder(order, bidId, transactionId);
                      },
                      child: Text("PAY"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext contx) {
    print("price:::::" + price.toString());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        color: Theme.of(contx).primaryColorLight,
        child: Column(
          children: [
            ListTile(
              title: Container(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    courierName,
                    style: TextStyle(
                      color: Theme.of(contx).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              subtitle: Text("Ahmedabad,GJ"),
              trailing: Container(
                margin: EdgeInsets.only(bottom: 15, right: 20),
                child: Chip(
                    backgroundColor: Theme.of(contx).primaryColorLight,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          color: Theme.of(contx).primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    avatar: Icon(
                      Icons.star,
                      color: Theme.of(contx).primaryColor,
                    ),
                    label: Text(
                      "4.8",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(contx).primaryColor,
                      ),
                    )),
              ),
            ),
            Divider(
              thickness: 3,
            ),
            ListTile(
              leading: Container(
                width: 40,
                height: 40,
                child: Image.asset(
                  'lib/assets/images/box2.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                "Shipment cost ~ ${price}",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "Expected Delivery Date ~ Dec 2,2021",
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "+More",
                    style: TextStyle(
                      color: Theme.of(contx).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        /*  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20)), */
                      ),
                      child: Text(
                        "Modes of transport~ " + modeOfTransport,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  if (!isCourierService)
                    Container(
                      width: 150,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        onPressed: () {
                          showDialog(
                            context: contx,
                            builder: (contx) {
                              return AlertDialog(
                                content: Text("Confirm Bid ?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(contx).pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(contx).pop();
                                      transactionDialogBox(contx);
                                    },
                                    child: Text("Confirm"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text("Accept"),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
