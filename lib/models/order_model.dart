import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:wecare_logistics/models/api_url.dart';
import 'dart:convert';
import 'package:wecare_logistics/models/bids_model.dart';

class Order {
  final String senderId;
  final String orderId;
  final String orderTitle;
  final String productCategory;
  final int productQuantity;
  final double productPrice;
  final double orderLendth;
  final double orderBreadth;
  final double orderHeight;
  final double orderWeight;
  final DateTime expectedDelivery;
  final String pickUpLocation;
  final String reciverName;
  final String dropLocation;
  final int pinCode;
  final DateTime orderCreatedOn;
  List<Bid> bids;
  bool published;
  bool bidSelected;
  bool orderCompleted;

  Order({
    required this.senderId,
    required this.orderId,
    required this.orderTitle,
    required this.productCategory,
    required this.productQuantity,
    required this.productPrice,
    required this.orderLendth,
    required this.orderBreadth,
    required this.orderHeight,
    required this.orderWeight,
    required this.expectedDelivery,
    required this.pickUpLocation,
    required this.reciverName,
    required this.dropLocation,
    required this.pinCode,
    required this.orderCreatedOn,
    this.bids = const [],
    this.published = false,
    this.bidSelected = false,
    this.orderCompleted = false,
  });
}

class OrdersProvider with ChangeNotifier {
  var userId;

  OrdersProvider({required this.userId, required List<Order> orders}) {
    this._ordersList = orders;
  }

  List<Order> _ordersList = [];

  Order copyWith(
      {String? senderId,
      String? orderId,
      String? orderTitle,
      String? productCategory,
      int? productQuantity,
      double? productPrice,
      double? orderLendth,
      double? orderBreadth,
      double? orderHeight,
      double? orderWeight,
      DateTime? expectedDelivery,
      String? pickUpLocation,
      String? reciverName,
      String? dropLocation,
      int? pinCode,
      DateTime? orderCreatedOn,
      bool? published,
      bool? bidSelected,
      List<Bid>? bid}) {
    return Order(
      senderId: senderId ?? "",
      orderId: orderId ?? "",
      orderTitle: orderTitle ?? " ",
      productCategory: productCategory ?? "",
      productQuantity: productQuantity ?? 0,
      productPrice: productPrice ?? 0,
      orderLendth: orderLendth ?? 0,
      orderBreadth: orderBreadth ?? 0,
      orderHeight: orderHeight ?? 0,
      orderWeight: orderWeight ?? 0,
      expectedDelivery: expectedDelivery ?? DateTime.now(),
      pickUpLocation: pickUpLocation ?? "",
      reciverName: reciverName ?? "",
      dropLocation: dropLocation ?? "",
      pinCode: pinCode ?? 0,
      orderCreatedOn: orderCreatedOn ?? DateTime.now(),
      published: published ?? false,
      bidSelected: bidSelected ?? false,
      bids: bid ?? [],
    );
  }

  Future<void> addNewOrder(Order newOrder, String deliveryDate) async {
    String responseId = '';
    try {
      var url = Uri.https('${Api.url}', 'orders.json');
      print('--------userId::' + userId);

      var response = await http.post(
        url,
        body: json.encode(
          {
            'senderId': userId,
            'pickUpLocation': newOrder.pickUpLocation,
            'reciverName': newOrder.reciverName,
            'dropLocation': newOrder.dropLocation,
            'deliveryPincode': newOrder.pinCode,
            'orderLength': newOrder.orderLendth,
            'orderBreadth': newOrder.orderBreadth,
            'orderHeight': newOrder.orderHeight,
            'orderWeight': newOrder.orderWeight,
            'orderTitle': newOrder.orderTitle,
            'orderCategory': newOrder.productCategory,
            'productPrice': newOrder.productPrice,
            'productQuantity': newOrder.productQuantity,
            'expectedDeliveryDate': newOrder.expectedDelivery.toIso8601String(),
            'orderCreatedOn': newOrder.orderCreatedOn.toIso8601String(),
            'orderPublishStatus': newOrder.published,
            'bidSelected': newOrder.bidSelected,
            'bids': newOrder.bids,
          },
        ),
      );
      if (response.statusCode >= 400) {
        print("Error occured in orderCreation first phase");
        return;
      }

      responseId = json.decode(response.body)['name'];
      print(response.body);
    } catch (error) {
      print("error caught::" + error.toString());
    }
    var order = Order(
      senderId: userId,
      published: newOrder.published,
      bidSelected: newOrder.bidSelected,
      orderId: responseId,
      orderTitle: newOrder.orderTitle,
      productCategory: newOrder.productCategory,
      productQuantity: newOrder.productQuantity,
      productPrice: newOrder.productPrice,
      orderLendth: newOrder.orderLendth,
      orderBreadth: newOrder.orderBreadth,
      orderHeight: newOrder.orderHeight,
      orderWeight: newOrder.orderWeight,
      expectedDelivery: DateFormat('d/M/y').parse(deliveryDate),
      pickUpLocation: newOrder.pickUpLocation,
      reciverName: newOrder.reciverName,
      dropLocation: newOrder.dropLocation,
      orderCreatedOn: DateTime.now(),
      pinCode: newOrder.pinCode,
      bids: newOrder.bids,
    );

    _ordersList.add(order);
    notifyListeners();
  }

  List<Order> getOrderList() {
    List<Order> order = [];

    _ordersList.forEach((element) {
      if (element.published == false) {
        order.add(element);
      }
    });

    return order;
  }

  Future<void> fetchOrder(bool isSender) async {
    print("inside fetch orders");
    var url = new Uri();
    try {
      if (isSender) {
        url = Uri.https(
          '${Api.url}',
          'orders.json',
          {
            'orderBy': json.encode("senderId"),
            'equalTo': json.encode(userId),
          },
        );
      }
      List<Order> temp = [];
      var response = await http.get(url);

      if (response.statusCode >= 400) {
        print(response.body);
        print("error occured in first phase of get order");
        return;
      }
      print(response.body);
      var decodeJsonString = json.decode(response.body) as Map<String, dynamic>;

      decodeJsonString.forEach((orderId, orderValue) {
        print("orderId::" + orderId);
        temp.add(Order(
          senderId: userId,
          orderId: orderId,
          orderTitle: orderValue['orderTitle'],
          productCategory: orderValue['orderCategory'],
          productQuantity: orderValue['productQuantity'],
          productPrice: orderValue['productPrice'],
          orderLendth: orderValue['orderLength'],
          orderBreadth: orderValue['orderBreadth'],
          orderHeight: orderValue['orderHeight'],
          orderWeight: orderValue['orderWeight'],
          expectedDelivery: DateTime.parse(orderValue['expectedDeliveryDate']),
          pickUpLocation: orderValue['pickUpLocation'],
          reciverName: orderValue['reciverName'],
          dropLocation: orderValue['dropLocation'],
          pinCode: orderValue['deliveryPincode'],
          orderCreatedOn: DateTime.parse(orderValue['orderCreatedOn']),
          published: orderValue['orderPublishStatus'],
          bidSelected: orderValue['bidSelected'],
        ));
      });
      setOrderList = [...temp];
      print("_orderList::" + _ordersList.length.toString());
    } catch (error) {
      print("error caught in catch block::" + error.toString());
    }
  }

  List<Order> getAllOrderList() {
    return [..._ordersList];
  }

  set setOrderList(List<Order> orders) {
    _ordersList = [...orders];
  }

  List<Order> getPublishedOrderList() {
    List<Order> publishedOrders = [];
    print("list order(zz)::" + _ordersList.length.toString());
    _ordersList.forEach((element) {
      if (element.published == true /* && element.bidSelected == false */) {
        publishedOrders.add(element);
      }
    });
    print("publis order(xx)::" + publishedOrders.length.toString());
    return publishedOrders;
  }

  Future<void> fetchPublishOrderList() async {
    try {
      var url = Uri.https(
        '${Api.url}',
        'orders.json',
        {
          'orderBy': json.encode("orderPublishStatus"),
          'equalTo': json.encode(true),
        },
      );

      var response = await http.get(url);

      print(response.body);
    } catch (error) {
      print(
          "error caught while fetching published orders::" + error.toString());
    }
  }

  Order getSingleOrder(String id) {
    /*   _ordersList.forEach((element) {
      print("order id::" + element.orderId);
    }); */

    print("publish order list length::" +
        getPublishedOrderList().length.toString());
    getPublishedOrderList().forEach((element) {
      print("orderId::" + element.orderId);
    });

    try {
      return _ordersList.singleWhere((element) => element.orderId == id);
    } catch (error) {
      print("error found::" + error.toString());
    }
    throw 1;
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      var url = Uri.https('${Api.url}', 'orders/$orderId.json');

      var response = await http.delete(url);

      if (response.statusCode >= 400) {
        print('error occured in network call() ');
        return;
      }
      _ordersList.removeWhere((element) => element.orderId == orderId);
      notifyListeners();
    } catch (error) {
      print("error ocured while deleting order::" + error.toString());
    }
  }

  Future<void> publishOrder(String id) async {
    try {
      var url = Uri.https('${Api.url}', 'orders/$id.json');

      var response = await http.patch(
        url,
        body: json.encode(
          {
            'orderPublishStatus': true,
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("error occured in network call");
        return;
      }

/*     var order = _ordersList.firstWhere((element) => element.orderId == id);
    order.published = !order.published; */

      notifyListeners();
    } catch (error) {
      print("error caugh while publishing order::" + error.toString());
    }
  }

  void ifBidSelected(Order order) {
    order.bidSelected = true;

    notifyListeners();
  }

 

  Future<void> fetchOrderBids(String orderId) async {
    try {
      var url = Uri.https('${Api.url}', 'bids/$orderId.json');
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
              courierName: bidData['courierName'],
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
}
