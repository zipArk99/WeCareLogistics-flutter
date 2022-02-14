import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:wecare_logistics/models/api_url.dart';

class Transcation {
  final String courierName;
  final String transactionType;
  final String transactionId;
  late String yourOrderId;
  final String senderId;
  final String courierId;
  final double transactionAmount;
  final DateTime transactionDate;

  Transcation({
    this.yourOrderId = '',
    this.transactionType = '',
    required this.transactionId,
    required this.senderId,
    required this.courierId,
    required this.transactionAmount,
    required this.transactionDate,
    required this.courierName,
    
  });
}

class TransactionProvider extends ChangeNotifier {
  final String userId;
  final List<Transcation> prevTransactionList;
  TransactionProvider(
      {required this.userId, required this.prevTransactionList});
  List<Transcation> transactionsList = [];

  //send transaction on
  Future<String> proccessTransaction(
      {required String courierName,
      required String courierId,
      required String senderId,
      required String transactionType,
      required String bidId,
      required double transactionAmount}) async {
    var decodedJsonString;
    DateTime transDate = DateTime.now();
    try {
      var url = Uri.https('${Api.url}', 'transactions.json');
      var response = await http.post(
        url,
        body: json.encode(
          {
            'courierName': courierName,
            'courierId': courierId,
            'senderId': senderId,
            'transactionType': transactionType,
            'yourOrderId':'',
            'transactionAmount': transactionAmount,
            'transactionDate': transDate.toIso8601String(),
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("network error called while proccessing transcation");
        return '';
      }

      decodedJsonString = json.decode(response.body) as Map<String, dynamic>;

      var trans = Transcation(
        courierName: courierName,
        transactionType: transactionType,
        transactionId: decodedJsonString['name'],
        courierId: courierId,
        senderId: senderId,
        yourOrderId: '',
        transactionAmount: transactionAmount,
        transactionDate: DateTime.parse(transDate.toIso8601String()),
      );
      transactionsList.add(trans);

      notifyListeners();
    } catch (error) {
      print("Error occured while proccessing transaction::" + error.toString());
    }
    notifyListeners();
    return decodedJsonString['name'].toString();
  }

  //Used to fetch transactions from server
  Future<void> fetchTransactions() async {
    try {
      var url = Uri.https(
        '${Api.url}',
        'transactions.json',
        {
          'orderBy': json.encode("senderId"),
          'equalTo': json.encode(userId),
        },
      );

      var response = await http.get(url);
      if (response.statusCode >= 400) {
        print("network call error occured while fetching transactions");
        return;
      }

      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;
      print(response.body);
      List<Transcation> temp = [];
      decodedJsonString.forEach((transactionId, transactionValue) {
        temp.add(
          Transcation(
            transactionType: transactionValue['transactionType'],
            courierName: transactionValue['courierName'],
            transactionId: transactionId,
            yourOrderId: transactionValue['yourOrderId'],
            senderId: transactionValue['senderId'],
            courierId: transactionValue['courierId'],
            transactionAmount: transactionValue['transactionAmount'],
            transactionDate:
                DateTime.parse(transactionValue['transactionDate']),
          ),
        );
      });

      transactionsList = [...temp];
    } catch (error) {
      print("error occured while fetching transactions::" + error.toString());
    }
  }

  List<Transcation> get getTransactionList {
    return [...transactionsList];
  }
}
