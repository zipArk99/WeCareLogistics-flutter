import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Transcation {
  final String transactionId;
  final String senderId;
  final String courierServiceId;
  final String orderId;
  final double transactionAmount;
  final DateTime transactionDate;

  Transcation({
    required this.transactionId,
    required this.senderId,
    required this.courierServiceId,
    required this.orderId,
    required this.transactionAmount,
    required this.transactionDate,
  });
}

class TransactionProvider extends ChangeNotifier {
  List<Transcation> transactionsList = [];

  void addTransaction(
      {required String senderId,
      required String courierServiceId,
      required String orderId,
      required double transactionAmount}) {
    Transcation transcation = Transcation(
      transactionId: Uuid().v4(),
      senderId: senderId,
      courierServiceId: courierServiceId,
      orderId: orderId,
      transactionAmount: transactionAmount,
      transactionDate: DateTime.now(),
    );

    transactionsList.add(transcation);

    print("list lenght::" + transactionsList.length.toString());

    notifyListeners();
  }
}
