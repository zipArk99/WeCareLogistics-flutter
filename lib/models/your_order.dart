import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wecare_logistics/models/api_url.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';

class YourOrder {
  YourOrder({
    required this.order,
    required this.selectedBid,
    required this.yourOrderDate,
    this.orderStatus = 'InActive',
    this.yourOrderId = '',
  });

  final Order order;
  late String orderStatus;
  final Map<String, dynamic> selectedBid;
  late DateTime yourOrderDate;
  late String yourOrderId;
}

class YourOrderProvider with ChangeNotifier {
  final String userId;
  YourOrderProvider(
      {required this.userId, required List<YourOrder> yourOrderList}) {
    setYourOrderList = [...yourOrderList];
  }

  List<YourOrder> _yourOrderList = [];

  List<YourOrder> get getYourOrderList {
    return [..._yourOrderList];
  }

  set setYourOrderList(yourlist) {
    _yourOrderList = [...yourlist];
  }

  Future<void> addYourOrder(
      Order order, String bidId, String transactionId) async {
    try {
      var url = Uri.https('${Api.url}', 'yourOrders.json');

      Bid bid = order.bids.firstWhere((element) {
        return element.bidId == bidId;
      });

      var response = await http.post(
        url,
        body: json.encode(
          {
            'senderId': order.senderId,
            'pickUpLocation': order.pickUpLocation,
            'reciverName': order.reciverName,
            'dropLocation': order.dropLocation,
            'deliveryPincode': order.pinCode,
            'orderLength': order.orderLendth,
            'orderBreadth': order.orderBreadth,
            'orderHeight': order.orderHeight,
            'orderWeight': order.orderWeight,
            'orderTitle': order.orderTitle,
            'orderCategory': order.productCategory,
            'productPrice': order.productPrice,
            'productQuantity': order.productQuantity,
            'expectedDeliveryDate': order.expectedDelivery.toIso8601String(),
            'orderCreatedOn': order.orderCreatedOn.toIso8601String(),
            'orderPublishStatus': order.published,
            'yourOrderStatus': 'Inactive',
            'yourOrderDate': DateTime.now().toIso8601String(),
            'selectedBid': {
              'courierName': bid.courierName,
              'courierId': bid.courierId,
              'bidPrice': bid.bidPrice,
              'bidExpectedDeliveryDate':
                  bid.bidExpectedDeliveryDate.toIso8601String(),
              'modeOfTransport': bid.modeOfTransport,
              'bidCreatedOn': bid.bidcreatedOn.toIso8601String(),
            }
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("Network call error occured while adding Your order");
        return;
      }

      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;

      var url2 = Uri.https('${Api.url}', 'transactions/$transactionId.json');
      print("transaction Id::" + transactionId);

      var response2 = await http.patch(
        url2,
        body: json.encode(
          {'yourOrderId': decodedJsonString['name'].toString()},
        ),
      );
      if (response2.statusCode >= 400) {
        print(
            "network call error occured while adding yourOrderId into transaction");
        return;
      }
      print(response2.body);
    } catch (error) {
      print("error occured while adding Your order::" + error.toString());
    }
  }

  Future<void> fetchYourOrder() async {
    try {
      var url = Uri.https(
        '${Api.url}',
        'yourOrders.json',
        {
          'orderBy': json.encode("senderId"),
          'equalTo': json.encode(userId),
        },
      );

      var reponse = await http.get(url);

      if (reponse.statusCode >= 400) {
        print("Network call error occured while fetching your order");
        return;
      }

      var decodedJsonString = json.decode(reponse.body) as Map<String, dynamic>;
      List<YourOrder> temp = [];
      print(reponse.body);
      decodedJsonString.forEach(
        (yourOrderId, yourOrderValue) {
          var order = Order(
            senderId: yourOrderValue['senderId'],
            orderId: '',
            orderTitle: yourOrderValue['orderTitle'],
            productCategory: yourOrderValue['orderCategory'],
            productQuantity: yourOrderValue['productQuantity'],
            productPrice: yourOrderValue['productPrice'],
            orderLendth: yourOrderValue['orderLength'],
            orderBreadth: yourOrderValue['orderBreadth'],
            orderHeight: yourOrderValue['orderHeight'],
            orderWeight: yourOrderValue['orderWeight'],
            expectedDelivery:
                DateTime.parse(yourOrderValue['expectedDeliveryDate']),
            pickUpLocation: yourOrderValue['pickUpLocation'],
            reciverName: yourOrderValue['reciverName'],
            dropLocation: yourOrderValue['dropLocation'],
            pinCode: yourOrderValue['deliveryPincode'],
            orderCreatedOn: DateTime.parse(yourOrderValue['orderCreatedOn']),
          );
          Map<String, dynamic> tempBid = {
            'courierName': yourOrderValue['selectedBid']['courierName'],
            'courierId': yourOrderValue['selectedBid']['courierId'],
            'bidPrice': yourOrderValue['selectedBid']['bidPrice'],
            'bidExpectedDeliveryDate': DateTime.parse(
                yourOrderValue['selectedBid']['bidExpectedDeliveryDate']),
            'modeOfTransport': yourOrderValue['selectedBid']['modeOfTransport'],
            'bidCreatedOn':
                DateTime.parse(yourOrderValue['selectedBid']['bidCreatedOn']),
          };
          temp.add(YourOrder(
              yourOrderDate: DateTime.parse(yourOrderValue['yourOrderDate']),
              yourOrderId: yourOrderId,
              order: order,
              selectedBid: tempBid,
              orderStatus: yourOrderValue['yourOrderStatus']));
        },
      );

      _yourOrderList = [...temp];
    } catch (error) {
      print("error occured while fetching your order::" + error.toString());
    }
  }
}
