import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/marketplace_order.dart';
import 'package:wecare_logistics/models/order_model.dart';

class MarketPlaceTab extends StatefulWidget {
  @override
  _MarketPlaceTabState createState() => _MarketPlaceTabState();
}

class _MarketPlaceTabState extends State<MarketPlaceTab> {
  bool init = true;
  bool isLoading = false;

  TextStyle standarFont() {
    return TextStyle(
      fontSize: 11,
    );
  }

  @override
  void didChangeDependencies() async {
    /* Provider.of<OrdersProvider>(context).fetchPublishOrderList(); */
    if (init) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<OrdersProvider>(context).fetchOrder(false);
      print("inside didChangeDependencies");
      setState(() {
        isLoading = false;
      });
      super.didChangeDependencies();
      init = false;
    }
  }

  @override
  Widget build(BuildContext contx) {
/*     var publishOrderList =
        Provider.of<OrdersProvider>(contx).getPublishedOrderList(); */
    /* var publishOrders = Provider.of<BidsProvider>(contx).checkUserBid(contx); */

    var publishedOrders =
        Provider.of<OrdersProvider>(contx).getPublishedOrderList();
    print("published orders::" + publishedOrders.length.toString());
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : publishedOrders.isEmpty
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
                      publishOrderId: publishedOrders[index].orderId,
                    );
                  },
                  itemCount: publishedOrders.length,
                ),
    );
  }
}
