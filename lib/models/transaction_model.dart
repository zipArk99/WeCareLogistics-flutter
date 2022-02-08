import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

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

  void addTransaction(
      {required String bidId,
      required String orderId,
      required double transactionAmount}) {
    Transcation transcation = Transcation(
      transactionId: Uuid().v4(),
      bidId: bidId,
      orderId: orderId,
      transactionAmount: transactionAmount,
      transactionDate: DateTime.now(),
    );

    transactionsList.add(transcation);

    print("list lenght::" + transactionsList.length.toString());

    notifyListeners();
  }
}
