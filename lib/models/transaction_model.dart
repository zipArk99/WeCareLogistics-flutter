import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:wecare_logistics/models/api_url.dart';

class Transcation {
  final String transactionId;
  final String orderId;
  final String bidId;
  final double transactionAmount;
  final DateTime transactionDate;

  Transcation({
    required this.transactionId,
    required this.orderId,
    required this.bidId,
    required this.transactionAmount,
    required this.transactionDate,
  });
}

class TransactionProvider extends ChangeNotifier {
  List<Transcation> transactionsList = [];

  Future<void> proccessTransaction(
      {required String bidId,
      required String orderId,
      required double transactionAmount}) async {
    DateTime transDate = DateTime.now();
    try {
      var url = Uri.https('${Api.url}', 'transactions.json');
      var response = await http.post(
        url,
        body: json.encode(
          {
            'orderId': orderId,
            'bidId': bidId,
            'transactionAmount': transactionAmount,
            'transacionDate': transDate.toIso8601String(),
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("network error called while proccessing transcation");
        return;
      }

      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;

      var trans = Transcation(
        transactionId: decodedJsonString['name'],
        orderId: orderId,
        bidId: bidId,
        transactionAmount: transactionAmount,
        transactionDate: DateTime.parse(transDate.toIso8601String()),
      );
      transactionsList.add(trans);
      notifyListeners();
    } catch (error) {
      print("Error occured while proccessing transaction::" + error.toString());
    }

    notifyListeners();
  }
}
