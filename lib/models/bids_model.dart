import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:wecare_logistics/models/order_model.dart';

class Bid {
  String orderId;
  String bidId;
  String courierId;
  double bidPrice;
  DateTime bidExpectedDeliveryDate;
  String modeOfTransport;
  DateTime bidcreatedOn;

  Bid({
    required this.orderId,
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
  List<Order> _publishOrderList = [];
  List<String> ordersId = [];
  final String user;
  BidsProvider({required this.user});

  Future<void> addBidInOrder(Bid bid, Order order) async {
    print(order.orderId);

    try {
      var url = Uri.https('logistics-87e01-default-rtdb.firebaseio.com',
          'bids/${bid.orderId}.json');

      var response = await http.post(
        url,
        body: json.encode(
          {
            'courierId': user,
            'bidPrice': bid.bidPrice,
            'bidExpectedDeliveryDate':
                bid.bidExpectedDeliveryDate.toIso8601String(),
            'modeOfTransport': bid.modeOfTransport,
            'bidCreatedOn': bid.bidcreatedOn.toIso8601String(),
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("network call error occured while placing bid");
        return;
      }

      var decodedJsonString = json.decode(response.body);

      var tempBid = Bid(
          orderId: bid.orderId,
          bidId: decodedJsonString['name'],
          courierId: bid.courierId,
          bidPrice: bid.bidPrice,
          bidExpectedDeliveryDate: bid.bidExpectedDeliveryDate,
          modeOfTransport: bid.modeOfTransport,
          bidcreatedOn: bid.bidcreatedOn);

      /*  order.bids.add(bid); */
      _bidedOrderList.add(order);

      url = Uri.https('logistics-87e01-default-rtdb.firebaseio.com',
          'bidedOrders/$user.json');

      response = await http.post(
        url,
        body: json.encode(
          {
            'orderId': order.orderId,
          },
        ),
      );

      notifyListeners();
    } catch (error) {
      print("error occured while placing bid::" + error.toString());
    }
  }

  Future<List<String>> fetchBidedOrderList() async {
    List<String> tempId = [];
    try {
      var url = Uri.https('logistics-87e01-default-rtdb.firebaseio.com',
          'bidedOrders/$user.json');

      var response = await http.get(url);
      if (response.statusCode >= 400) {
        print("error occured in network call while fetching bided order list");
      }

      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;
      decodedJsonString.forEach(
        (bidedOrderId, orderData) {
          print("inside bided order::" + orderData['orderId']);
          tempId.add(orderData['orderId']);
        },
      );
      ordersId = [...tempId];
    } catch (error) {
      print(
          "error occured while fetching bided order list::" + error.toString());
    }
    return ordersId;
  }

/*   Future<void> fetchBid() async {
    try {
      var url = Uri.https(
        'logistics-87e01-default-rtdb.firebaseio.com',
        'bids.json',
        {
          'orderBy': json.encode('courierId'),
          'equalTo': json.encode(user),
        },
      );
      List<String> tempOrderId = [];
      var response = await http.get(url);

      if (response.statusCode >= 400) {
        print("error in network while fetching bided orders list");
        return;
      }
      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;

      decodedJsonString.forEach(
        (bidId, bidData) {
          tempOrderId.add(
            bidData['courierId'],
          );
        },
      );

      tempOrderId.forEach((element) {});
    } catch (error) {
      print("error occured while fetching bided orders::" + error.toString());
    }
  } */

  Future<void> filterBidedOrders(BuildContext context) async {
    var order = Provider.of<OrdersProvider>(context, listen: false);

    List<String> bidedOrderId = await fetchBidedOrderList();
    List<Order> publishOrder = order.getPublishedOrderList();

    bidedOrderId.forEach((element) {
      print("element:" + element);
    });
    List<Order> tempOrder = [];

    for (int i = 0; i < bidedOrderId.length; i++) {
      for (int j = 0; j < publishOrder.length; j++) {
        if (bidedOrderId[i] == publishOrder[j].orderId) {
          tempOrder.add(publishOrder[j]);
          print("inside logic::" + publishOrder[j].orderId);
        }
      }
    }
    setBidedOrderList = [...tempOrder];
  }

  Future<void> fetchFilteredPublishList(BuildContext context) async {
    try {
      await filterBidedOrders(context);

      var url = Uri.https(
        'logistics-87e01-default-rtdb.firebaseio.com',
        'orders.json',
        {
          'orderBy': json.encode("orderPublishStatus"),
          'equalTo': json.encode(true),
        },
      );

      var response = await http.get(url);
      if (response.statusCode >= 400) {
        print(
            "network call error occured while fetching published orders for courier service");
        return;
      }

      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;
      List<Order> tempPublishOrder = [];
      List<Order> tempBidedOrders = [];
      decodedJsonString.forEach(
        (orderId, orderValue) {
          var order = Order(
            senderId: orderValue['senderId'].toString(),
            orderId: orderId.toString(),
            bidSelected: orderValue['bidSelected'],
            orderTitle: orderValue['orderTitle'],
            productCategory: orderValue['orderCategory'],
            productQuantity: orderValue['productQuantity'],
            productPrice: orderValue['productPrice'],
            orderLendth: orderValue['orderLength'],
            orderBreadth: orderValue['orderBreadth'],
            orderHeight: orderValue['orderHeight'],
            orderWeight: orderValue['orderWeight'],
            expectedDelivery:
                DateTime.parse(orderValue['expectedDeliveryDate']),
            pickUpLocation: orderValue['pickUpLocation'],
            reciverName: orderValue['reciverName'],
            dropLocation: orderValue['dropLocation'],
            pinCode: orderValue['deliveryPincode'],
            orderCreatedOn: DateTime.parse(orderValue['orderCreatedOn']),
            published: orderValue['orderPublishStatus'],
          );
          if (!ordersId.contains(orderId)) {
            tempPublishOrder.add(order);
          } else {
            tempBidedOrders.add(order);
          }
        },
      );
      setPublishOrderList = [...tempPublishOrder];
      setBidedOrderList = [...tempBidedOrders];
    } catch (error) {
      print(
          "error occured while fetching published orders for courier service::" +
              error.toString());
    }
  }

  Future<void> fetchOrderBids(String orderId) async {
    try {
      var url = Uri.https(
          'logistics-87e01-default-rtdb.firebaseio.com', 'bids/$orderId.json');
      var response = await http.get(url);

      if (response.statusCode >= 400) {
        print("error occured in network call while fetching data");
        return;
      }
      List<Bid> tempbid = [];
      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;

      decodedJsonString.forEach(
        (bidId, bidData) {
          tempbid.add(
            Bid(
              orderId: orderId,
              bidId: bidId,
              courierId: bidData['courierId'],
              bidPrice: bidData['bidPrice'],
              bidExpectedDeliveryDate:
                  DateTime.parse(bidData['bidExpectedDeliveryDate']),
              modeOfTransport: bidData['modeOfTransport'],
              bidcreatedOn: DateTime.parse(bidData['bidCreatedOn']),
            ),
          );
        },
      );

      var order = getSingleOrder(orderId);
      order.bids = [...tempbid];
      print(response.body);
    } catch (error) {
      print("error occured while fetching bids::" + error.toString());
    }
  }

  Bid getCourierBid(String orderId) {
    var order = getSingleOrder(orderId);

    Bid bid = order.bids.firstWhere((element) {
      return element.courierId == user;
    });

    return bid;
  }

  List<Order> get getBidedOrderList {
    return [..._bidedOrderList];
  }

  List<Order> get getPubishOrderList {
    return [..._publishOrderList];
  }

  Order getSingleOrder(String orderId) {
    List<Order> tempOrders = [];
    tempOrders = [...getPubishOrderList, ...getBidedOrderList];
    return tempOrders.firstWhere((element) {
      return element.orderId == orderId;
    });
  }

  set setBidedOrderList(List<Order> orders) {
    _bidedOrderList = [...orders];
  }

  set setPublishOrderList(List<Order> orders) {
    _publishOrderList = [...orders];
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
}
