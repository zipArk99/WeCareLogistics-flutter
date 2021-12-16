import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

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
  bool published;

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
    this.published = false,
  });
}

class OrdersProvider with ChangeNotifier {
  List<Order> _ordersList = [];

  List<Order> getOrderList() {
    return [..._ordersList];
  }

  Order getSingleOrder(String id) {
    return getOrderList().singleWhere((element) => element.orderId == id);
  }

  Order copyWith(
      {String? orderId,
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
      bool? published}) {
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
        published: published ?? false);
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

  void deleteOrder(String id) {
    _ordersList.removeWhere((element) => element.orderId == id);
    notifyListeners();
  }
}
