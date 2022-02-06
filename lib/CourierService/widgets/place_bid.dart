import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/models/user.dart';

class BottomSheetWidget {
  BottomSheetWidget(
      {required BuildContext contx,
      required String orderId,
      bool isEdit = false}) {
    showModalBottomSheet(
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      context: contx,
      builder: (contx) {
        return PlaceBidBottomModelSheetWidget(
          orderId: orderId,
          isEdit: isEdit,
        );
      },
    );
  }
}

class PlaceBidBottomModelSheetWidget extends StatefulWidget {
  final String orderId;
  final bool isEdit;
  PlaceBidBottomModelSheetWidget({required this.orderId, required this.isEdit});
  @override
  State<StatefulWidget> createState() {
    return PlaceBidBottomModelSheetWidgetState();
  }
}

class PlaceBidBottomModelSheetWidgetState
    extends State<PlaceBidBottomModelSheetWidget> {
  var _intiModeValue;
  var _selectedDate;
  double? _bidPrice = 0.0;
  bool init = true;
  var _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    if (widget.isEdit) {
      if (init) {
        var user = Provider.of<UserProvider>(context, listen: false).getUser();
        var order = Provider.of<OrdersProvider>(context, listen: false)
            .getSingleOrder(widget.orderId);

        Bid bid = order.bids.firstWhere((element) {
          return element.courierId == user.id;
        });

        _bidPrice = bid.bidPrice;
        _intiModeValue = bid.modeOfTransport;
        _selectedDate = bid.bidExpectedDeliveryDate;

        init = false;
      }
    }
    super.didChangeDependencies();
  }

  void changeItem(Object? value) {
    setState(() {
      _intiModeValue = value.toString();
    });
  }

  void confirmBid(BuildContext contx) {
    print("called");
    bool validate = _formKey.currentState!.validate();
    if (!validate || _selectedDate == null) {
      return;
    }

    _formKey.currentState!.save();
    var user = Provider.of<UserProvider>(contx, listen: false).getUser();
    var singleOrder = Provider.of<OrdersProvider>(contx, listen: false)
        .getSingleOrder(widget.orderId);
    showDialog(
        context: contx,
        builder: (contx) {
          return AlertDialog(
            content: Text("Confirm Your Bid ?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(contx).pop();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  Bid bid = Bid(
                      orderId: singleOrder.orderId,
                      bidId: Uuid().v4(),
                      courierId: user.id,
                      bidPrice: _bidPrice as double,
                      bidExpectedDeliveryDate: _selectedDate,
                      modeOfTransport: _intiModeValue.toString(),
                      bidcreatedOn: DateTime.now());

                  if (widget.isEdit) {
                    Provider.of<BidsProvider>(context, listen: false)
                        .editBid(singleOrder, user.id, bid);
                  } else {
                    Provider.of<BidsProvider>(context, listen: false)
                        .addBidInOrder(bid, singleOrder);
                  }
                  Navigator.of(contx).pop();
                  Navigator.of(contx).pop();
                  ScaffoldMessenger.of(contx).showSnackBar(
                    SnackBar(
                      content: Text("Bid Placed Successfully"),
                    ),
                  );
                },
                child: Text("Confirm"),
              ),
            ],
          );
        });
  }

  Future<void> selectDeliveryDate(BuildContext contx) async {
    var date = await showDatePicker(
        context: contx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));

    if (date == null) {
      setState(() {
        _selectedDate = null;
        return;
      });
    }

    setState(() {
      _selectedDate = date;
      date = null;
    });
  }

  @override
  Widget build(BuildContext contx) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.only(left: 30, right: 30, top: 70, bottom: 20),
                  child: TextFormField(
                    initialValue: _bidPrice.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Bid Price"),
                    onSaved: (value) {
                      _bidPrice = double.parse(value.toString());
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Field!";
                      } else if (double.tryParse(value) == null) {
                        return "Digit only!";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    onChanged: (value) {
                      changeItem(value);
                    },
                    value: _intiModeValue,
                    items: ['Road', 'Air', 'Rail']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    hint: Text(
                      "Select Mode Of Transport",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "Empty field!";
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _selectedDate != null
                    ? Text(_selectedDate.toString())
                    : Text("No Date Selected"),
                TextButton(
                  onPressed: () {
                    selectDeliveryDate(contx);
                  },
                  child: Text("Select Date"),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                confirmBid(contx);
              },
              child: widget.isEdit ? Text("Edit Bid") : Text("Place Bid"),
            ),
          ),
        ],
      ),
    );
  }
}
