import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/Exceptions/not_enough_balance.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/models/transaction_model.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/models/your_order.dart';
import 'package:wecare_logistics/sender/screens/send_yourorder_tab.dart';
import 'package:wecare_logistics/sender/screens/sender_wallet.dart';

class TransactionDialogBox {
  TransactionDialogBox(
      {required BuildContext contx,
      required String courierName,
      required String courierId,
      required String bidId,
      required double price,
      required Order order}) {
    showDialog(
        context: contx,
        builder: (contx) {
          return Dialog(
            child: TransactionWidget(
              courierName: courierName,
              courierId: courierId,
              bidId: bidId,
              price: price,
              order: order,
            ),
          );
        });
  }
}

class TransactionWidget extends StatefulWidget {
  final String courierName;
  final String courierId;
  final String bidId;
  final double price;
  final Order order;

  TransactionWidget({
    required this.courierName,
    required this.courierId,
    required this.bidId,
    required this.price,
    required this.order,
  });
  @override
  State<StatefulWidget> createState() {
    return TransactionWidgetState();
  }
}

class TransactionWidgetState extends State<TransactionWidget> {
  bool isLoading = false;

  @override
  Widget build(BuildContext contx) {
    return Container(
      height: 250,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Wait For Transaction To Complete"),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : Column(
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
                    initialValue: widget.price.toString(),
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
                      var user = Provider.of<UserProvider>(context,listen:false);

                      if (user.checkWalletBalance(widget.price)) {
                        setState(() {
                          isLoading = true;
                        });
                        var transactionId = '';

                        transactionId = await Provider.of<TransactionProvider>(
                                contx,
                                listen: false)
                            .proccessTransaction(
                          courierName: widget.courierName,
                          courierId: widget.courierId,
                          transactionType: 'payment',
                          bidId: widget.bidId,
                          senderId: widget.order.senderId,
                          transactionAmount: widget.price,
                        );

                        var bid =
                            Provider.of<BidsProvider>(contx, listen: false);

                        await Provider.of<YourOrderProvider>(contx,
                                listen: false)
                            .addYourOrder(
                                widget.order, widget.bidId, transactionId);
                        await user.walletTransaction(
                                amount: widget.price,
                                courierId: widget.courierId);

                        await bid.deleteBidedOrders(widget.order, widget.bidId);
                        await bid.deleteBids(widget.order);

                        await Provider.of<OrdersProvider>(contx, listen: false)
                            .deleteOrder(widget.order.orderId);

                        Navigator.of(contx).pushReplacementNamed(
                            SenderYourOrderTabs.senderYourOrderTabsRoute);
                      } else {
                        Navigator.of(context).pop();

                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text(
                                  "Insufficient Blanace add money to wallet !",
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor),
                                ),
                                actions: [
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.green,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pushNamed(
                                          SenderWallet.senderWalletRoute);
                                    },
                                    child: Text("OK"),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.red,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Cancel"),
                                  ),
                                ],
                              );
                            });
                      }
                    },
                    child: Text("PAY"),
                  ),
                ),
              ],
            ),
    );
  }
}
