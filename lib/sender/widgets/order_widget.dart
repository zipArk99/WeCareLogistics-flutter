import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:wecare_logistics/models/order_model.dart';

import 'package:wecare_logistics/screens/order_detail_screen.dart';

class OrdersWidget extends StatefulWidget {
  final String id;
  final String orderTitle;
  final String pickUpLocation;
  final String dropLocation;
  final bool published;
  int count;
  OrdersWidget(
      {required Key key,
      required this.id,
      required this.orderTitle,
      required this.pickUpLocation,
      required this.dropLocation,
      required this.published,
      required this.count})
      : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  @override
  void didChangeDependencies() {
    if (widget.published) {
      Provider.of<OrdersProvider>(context).fetchOrderBids(widget.id);
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          onTap: () {
            /* ChangeNotifierProvider(create: (contx) => BidsProvider()); */
            Navigator.of(contx).pushNamed(
              OrderDetailScreen.OrderDetailScreenRoute,
              arguments: {
                'orderId': widget.id,
                'isCourierService': false,
              },
            );
          },
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text(
              "${++widget.count}",
              style: TextStyle(fontSize: 25),
            ),
          ),
          title: Text(widget.orderTitle),
          subtitle: Text(
            "${widget.pickUpLocation}-->${widget.dropLocation}",
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          trailing: Stack(
            children: [
              Positioned(
                right: 20,
                child: Container(
                  height: 30,
                  width: 30,
                  child: Chip(
                    label: Text('hello'),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {
                    Provider.of<OrdersProvider>(contx, listen: false)
                        .deleteOrder(widget.id);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 30,
                    color: Theme.of(contx).errorColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
