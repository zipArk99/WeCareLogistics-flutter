import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_your_order.dart';
import 'package:wecare_logistics/models/your_order.dart';

class CourierActiveOrderTab extends StatefulWidget {
  @override
  _CourierActiveOrderTabState createState() => _CourierActiveOrderTabState();
}

class _CourierActiveOrderTabState extends State<CourierActiveOrderTab> {
  bool isInit = true;
  bool isLoading = false;

  @override
  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<YourOrderProvider>(context, listen: false)
          .fetchYourOrder(false);
      setState(() {
        isLoading = false;
      });
      isInit = false;
      super.didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext contx) {
    List<YourOrder> yourOrderList =
        Provider.of<YourOrderProvider>(contx, listen: false).getYourOrderList;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemBuilder: (contx, index) {
              return CourierYourOrder(
                yourOrderId: yourOrderList[index].yourOrderId,
                orderWeight: yourOrderList[index].order.orderWeight,
                orderLendth: yourOrderList[index].order.orderLendth,
                orderBreadth: yourOrderList[index].order.orderBreadth,
                orderHeight: yourOrderList[index].order.orderHeight,
                pickUpLocation: yourOrderList[index].order.pickUpLocation,
                dropLocation: yourOrderList[index].order.dropLocation,
                orderStatus: yourOrderList[index].orderStatus,
              );
            },
            itemCount: yourOrderList.length,
          );
  }
}
