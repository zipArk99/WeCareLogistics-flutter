import 'package:flutter/cupertino.dart';

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
    this.published = false,
  });
}

class OrdersProvider with ChangeNotifier {
  List<Order> ordersList = [];
}
