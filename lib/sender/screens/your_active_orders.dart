import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/your_order.dart';
import 'package:wecare_logistics/sender/widgets/yourorder_widget.dart';

class YourActiveOrders extends StatefulWidget {
  @override
  _YourActiveOrdersState createState() => _YourActiveOrdersState();
}

class _YourActiveOrdersState extends State<YourActiveOrders> {
  bool isInit = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<YourOrderProvider>(context, listen: false)
        .fetchYourOrder(true);
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
    isInit = false;
  }

  Future<void> fetchYourOrder() async {
    didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    List<YourOrder> yourOrderList =
        Provider.of<YourOrderProvider>(contx).getYourOrderList;

    return RefreshIndicator(
      onRefresh: () {
        return fetchYourOrder();
      },
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemBuilder: (contx, index) {
                return YourOrderWidget(
                    yourOrderStatus: yourOrderList[index].orderStatus,
                    pickUpDate: yourOrderList[index].pickUpDate,
                    pickUpFromDate: yourOrderList[index].pickUpFromTime,
                    pickUpToDate: yourOrderList[index].pickUpToTime,
                    yourOrderWeight: yourOrderList[index].order.orderWeight,
                    yourOrderPickUp: yourOrderList[index].order.pickUpLocation,
                    yourOrderId: yourOrderList[index].yourOrderId,
                    yourOrderDate: yourOrderList[index].yourOrderDate,
                    reciverName: yourOrderList[index].order.reciverName,
                    productTitle: yourOrderList[index].order.orderTitle,
                    dropLocation: yourOrderList[index].order.dropLocation,
                    courierServiceName:
                        yourOrderList[index].selectedBid['courierName'],
                    price: yourOrderList[index].selectedBid['bidPrice']);
              },
              itemCount: yourOrderList.length,
            ),
    );
  }
}
