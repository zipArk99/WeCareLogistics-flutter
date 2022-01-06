import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/marketplace_order.dart';
import 'package:wecare_logistics/models/bids_model.dart';

class MyBidsTab extends StatelessWidget {
  @override
  Widget build(BuildContext contx) {
    var bidOrderList = Provider.of<BidsProvider>(contx).getBidedOrderList;

    return Scaffold(
      body: bidOrderList.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 80),
                child: Column(
                  children: [
                    Text(
                      "No Orders!",
                      style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(contx).errorColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      child: Image.asset(
                        'lib/assets/images/waiting.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (contx, index) {
                return MarketPlaceOrderWidget(
                  publishOrderId: bidOrderList[index].orderId,
                );
              },
              itemCount: bidOrderList.length,
            ),
    );
  }
}
