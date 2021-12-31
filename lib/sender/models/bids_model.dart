import 'package:flutter/cupertino.dart';

import 'package:wecare_logistics/sender/models/order_model.dart';

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

  void addBidInOrder(String id, Bid bid) {
    var order = OrdersProvider().getSingleOrder(id);
    order.bids.add(
      Bid(
        bidId: "fsdf",
        courierId: "575d77X7",
        bidPrice: 899,
        bidExpectedDeliveryDate: DateTime.now(),
        modeOfTransport: "Road",
        bidcreatedOn: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
