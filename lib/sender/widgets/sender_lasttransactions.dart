import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SenderLastTransactionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext contx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Card(
        child: ListTile(
          title: Text(
            "Chintu Service",
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
            "- \$140.00",
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
