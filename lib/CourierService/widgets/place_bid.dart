import 'package:flutter/material.dart';

class BottomSheetWidget {
  void openPlaceBidBottomModelSheet(BuildContext contx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: contx,
        builder: (contx) {
          return PlaceBidBottomModelSheetWidget();
        });
  }
}

class PlaceBidBottomModelSheetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlaceBidBottomModelSheetWidgetState();
  }
}

class PlaceBidBottomModelSheetWidgetState
    extends State<PlaceBidBottomModelSheetWidget> {
  var intiValue;
  var selectedDate;
  double? bidPrice;
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext contx) {
    void changeItem(Object? value) {
      setState(() {
        intiValue = value.toString();
      });
    }

    void confirmBid(BuildContext contx) {
      print("called");
      bool validate = _formKey.currentState!.validate();
      if (!validate || selectedDate == null) {
        return;
      }

      _formKey.currentState!.save();

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
                  onPressed: () {},
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
          selectedDate = null;
          return;
        });
      }

      setState(() {
        selectedDate = date;
        date = null;
      });
    }

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
                        bidPrice = double.parse(value.toString());
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
                      value: intiValue,
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
                selectedDate != null
                    ? Text(selectedDate.toString())
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
