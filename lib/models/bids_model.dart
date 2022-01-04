import 'package:flutter/cupertino.dart';

import 'package:wecare_logistics/models/order_model.dart';

class Bid {
  final String bidId;
  final String courierId;
  final double bidPrice;
  final DateTime bidExpectedDeliveryDate;
  final String modeOfTransport;
  DateTime bidcreatedOn;

  Bid({
    required this.bidId,
    required this.courierId,
    required this.bidPrice,
    required this.bidExpectedDeliveryDate,
    required this.modeOfTransport,
    required this.bidcreatedOn,
  });
}

class BidsProvider with ChangeNotifier {
  List<Bid> _bidsList = [
    Bid(
      bidId: "fsdf",
      courierId: "575d77X7",
      bidPrice: 899,
      bidExpectedDeliveryDate: DateTime.now(),
      modeOfTransport: "Road",
      bidcreatedOn: DateTime.now(),
    )
  ];

  Future<void> addBidInOrder(String id, Bid bid) async {
    print("hello i am called::" + id);
    var order = OrdersProvider().getSingleOrder(id);
    order.bids.add(bid);
    notifyListeners();
  }
}
