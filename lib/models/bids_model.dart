import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/models/user.dart';

class Bid {
  final String bidId;
  final String courierId;
  double bidPrice;
  DateTime bidExpectedDeliveryDate;
  String modeOfTransport;
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
  List<Order> _bidedOrderList = [];

  Future<void> addBidInOrder(Bid bid, Order order) async {
    order.bids.add(bid);
    _bidedOrderList.add(order);

    notifyListeners();
  }

  List<Order> get getBidedOrderList {
    return [..._bidedOrderList];
  }

  void editBid(Order order, String userId, Bid bidElement) async {
    Bid bid = order.bids.firstWhere((element) {
      return element.courierId == userId;
    });

    /*    if (bid.editCounter <= 1) {
      print("--Bid Update Called--::" + bid.editCounter.toString());
      bid.editCounter = bid.editCounter++;
      bid.bidPrice = bidElement.bidPrice;
      bid.bidExpectedDeliveryDate = bidElement.bidExpectedDeliveryDate;
      bid.modeOfTransport = bidElement.modeOfTransport;
      notifyListeners();
      return true;
    } */
  }

  List<Order> checkUserBid(BuildContext contx) {
    List<Order> tempOrder = [];
    var publishOrderList = Provider.of<OrdersProvider>(contx, listen: false)
        .getPublishedOrderList();
    var user = Provider.of<UserProvider>(contx, listen: false);

    for (int i = 0; i < publishOrderList.length; i++) {
      if (publishOrderList[i].bids.isNotEmpty) {
        publishOrderList[i].bids.forEach((element) {
          if (element.courierId == user.getUser().id) {
          } else {
            tempOrder.add(publishOrderList[i]);
          }
        });
      } else {
        tempOrder.add(publishOrderList[i]);
      }
    }
    return tempOrder;
  }
}
