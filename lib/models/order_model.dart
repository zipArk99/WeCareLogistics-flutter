import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wecare_logistics/models/bids_model.dart';

class Order {
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
  List<Order> _ordersList = [
    Order(
      orderId: Uuid().v4(),
      orderTitle: "Tshirt",
      productCategory: "Clothing",
      productQuantity: 2,
      productPrice: 200,
      orderLendth: 100,
      orderBreadth: 100,
      orderHeight: 50,
      orderWeight: 10,
      expectedDelivery: DateTime.now(),
      pickUpLocation: "Ahmedabad",
      reciverName: "Shaun",
      dropLocation: "mumbai",
      pinCode: 380015,
      bids: [],
      orderCreatedOn: DateTime.now(),
    ),
    Order(
        orderId: Uuid().v4(),
        orderTitle: "Tshirt",
        productCategory: "Clothing",
        productQuantity: 2,
        productPrice: 200,
        orderLendth: 100,
        orderBreadth: 100,
        orderHeight: 50,
        orderWeight: 10,
        expectedDelivery: DateTime.now(),
        pickUpLocation: "Ahmedabad",
        reciverName: "Shaun",
        dropLocation: "mumbai",
        pinCode: 380015,
        bids: [],
        orderCreatedOn: DateTime.now(),
        published: false),
  ];

  Order copyWith({
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
    /*  List<Bid>? bid */
  }) {
    return Order(
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
      /*  bids:bid ?? [] */
    );
  }

  void addNewOrder(Order newOrder, String deliveryDate) {
    var uuid = Uuid();
    var order = Order(
      published: newOrder.published,
      orderId: uuid.v4(),
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

  List<Order> getPublishedOrderList() {
    List<Order> publishedOrders = [];

    _ordersList.forEach((element) {
      if (element.published == true) {
        publishedOrders.add(element);
      }
    });

    return publishedOrders;
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

  void deleteOrder(String id) {
    _ordersList.removeWhere((element) => element.orderId == id);
    notifyListeners();
  }

  void publishOrder(String id) {
    var order = _ordersList.firstWhere((element) => element.orderId == id);
    order.published = !order.published;

    notifyListeners();
  }

  Future<void> addBidToOrder(String id, Bid bid) async {
    Order order = getSingleOrder(id);
    order.bids.add(bid);
    ChangeNotifier();
  }
}
