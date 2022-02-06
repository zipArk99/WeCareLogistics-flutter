import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/marketplace_order.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';

class MyBidsTab extends StatefulWidget {
  @override
  _MyBidsTabState createState() => _MyBidsTabState();
}

class _MyBidsTabState extends State<MyBidsTab> {
  bool init = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    if (init) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<BidsProvider>(context).filterBidedOrders(context);
      setState(() {
        isLoading = false;
      });
      init = false;
    }
  }

  @override
  Widget build(BuildContext contx) {
    var bidOrderList = Provider.of<BidsProvider>(contx).getBidedOrderList;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bidOrderList.isEmpty
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
