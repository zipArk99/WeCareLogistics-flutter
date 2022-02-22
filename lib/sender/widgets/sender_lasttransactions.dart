import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderLastTransactionsWidget extends StatelessWidget {
  final String courierName;
  final String senderName;
  final DateTime transactionDate;
  final double transactionAmount;
  final bool isSender;

  SenderLastTransactionsWidget({
    required this.courierName,
    required this.transactionAmount,
    required this.transactionDate,
    required this.isSender,
    required this.senderName,
  });
  @override
  Widget build(BuildContext contx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Card(
        child: ListTile(
          title: Text(
            isSender ? courierName : senderName,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            DateFormat('dd MMM').format(
              transactionDate,
            ),
          ),
          trailing: isSender
              ? Text(
                  "- \u{20B9}$transactionAmount",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(contx).errorColor,
                  ),
                )
              : Text(
                  "+ \u{20B9}$transactionAmount",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
        ),
      ),
    );
  }
}
