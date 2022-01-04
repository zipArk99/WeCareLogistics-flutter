import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:wecare_logistics/models/bids_model.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/models/user.dart';

class BottomSheetWidget {
  BottomSheetWidget({required BuildContext contx, required String orderId}) {
    showModalBottomSheet(
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
          );
        });
  }
}

class PlaceBidBottomModelSheetWidget extends StatefulWidget {
  String orderId;
  PlaceBidBottomModelSheetWidget({required this.orderId});
  @override
  State<StatefulWidget> createState() {
    return PlaceBidBottomModelSheetWidgetState();
  }
}

class PlaceBidBottomModelSheetWidgetState
    extends State<PlaceBidBottomModelSheetWidget> {
  var _intiModeValue;
  var _selectedDate;
  double? _bidPrice;
  var _formKey = GlobalKey<FormState>();

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
                      bidId: Uuid().v4(),
                      courierId: user.id,
                      bidPrice: _bidPrice as double,
                      bidExpectedDeliveryDate: _selectedDate,
                      modeOfTransport: _intiModeValue.toString(),
                      bidcreatedOn: DateTime.now());
                  try {
                    Provider.of<OrdersProvider>(context, listen: false)
                        .addBidToOrder(widget.orderId, bid)
                        .then((value) {
                      Navigator.of(contx).pop();
                      Navigator.of(contx).pop();
                    });
                  } catch (error) {
                    print("this is the error::" + error.toString());
                  }
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
                    margin: EdgeInsets.only(
                        left: 30, right: 30, top: 70, bottom: 20),
                    child: TextFormField(
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
              )),
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
              child: Text("Place Bid"),
            ),
          ),
        ],
      ),
    );
  }
}
