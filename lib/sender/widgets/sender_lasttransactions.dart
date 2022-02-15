import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderLastTransactionsWidget extends StatelessWidget {
  final String courierName;
  final DateTime transactionDate;
  final double transactionAmount;

  SenderLastTransactionsWidget({
    required this.courierName,
    required this.transactionAmount,
    required this.transactionDate,
  });
  @override
  Widget build(BuildContext contx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Card(
        child: ListTile(
          title: Text(
            courierName,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          subtitle: Text(
            DateFormat('dd MMM').format(
              DateTime.now(),
            ),
          ),
          trailing: Text(
            "- \u{20B9}$transactionAmount",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Theme.of(contx).errorColor,
            ),
          ),
        ),
      ),
    );
  }
}
