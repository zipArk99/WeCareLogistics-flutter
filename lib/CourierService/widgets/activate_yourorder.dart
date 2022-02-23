import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/your_order.dart';

class ShowActivateDialogBox {
  BuildContext contx;
  final String yourOrderId;
  ShowActivateDialogBox({required this.contx, required this.yourOrderId}) {
    showDialog(
        context: contx,
        builder: (contx) {
          return ActivateYourOrder(yourOrderId: yourOrderId);
        });
  }
}

class ActivateYourOrder extends StatefulWidget {
  final String yourOrderId;
  ActivateYourOrder({required this.yourOrderId});
  @override
  State<StatefulWidget> createState() {
    return ActivateYourOrderState();
  }
}

class ActivateYourOrderState extends State<ActivateYourOrder> {
  late String pickUpDate = '';
  late String pickUpFromTime = 'From';
  late String pickUpToTime = 'To';
  bool isLoading = false;

  Future<void> selectPickUpDate(
    BuildContext contx,
  ) async {
    var date = await showDatePicker(
        context: contx,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));

    if (date != null) {
      setState(() {
        pickUpDate = DateFormat('dd MMM').format(date);
        print("pickUpDate::" + pickUpDate.toString());
      });
    } else {
      setState(() {
        pickUpDate = '';
      });
    }
  }

  void selectFromPickUpTime(BuildContext contx) async {
    var fromTime = await showTimePicker(
      context: contx,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (fromTime != null) {
      setState(() {
        var localization = MaterialLocalizations.of(context);
        pickUpFromTime = localization.formatTimeOfDay(fromTime);
        print(pickUpFromTime);
      });
    } else {
      setState(() {
        pickUpFromTime = '';
      });
    }
  }

  bool checkFieldsStatus() {
    if (pickUpDate != '' && pickUpFromTime != 'From' && pickUpToTime != 'To') {
      return true;
    }
    return false;
  }

  void selectToPickUpTime(BuildContext contx) async {
    var toTime = await showTimePicker(
      context: contx,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (toTime != null) {
      setState(() {
        var localization = MaterialLocalizations.of(context);
        print("inside date");
        pickUpToTime = localization.formatTimeOfDay(toTime);
        print(pickUpToTime);
      });
    } else {
      setState(() {
        pickUpToTime = '';
      });
    }
  }

  Widget createTextField(String label, Function() fun, String value) {
    return Expanded(
      child: Container(
        height: 35,
        child: TextFormField(
          readOnly: true,
          onTap: fun,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 10),
            border: OutlineInputBorder(),
            hintText: value,
            prefixIcon: Icon(Icons.av_timer_rounded),
            labelStyle: TextStyle(
              fontSize: 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    print("inside activate order");
    return Dialog(
      child: Container(
        height: 300,
        padding: EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                pickUpDate == ''
                    ? Text("Select pick up date")
                    : Text(
                        pickUpDate,
                        style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(contx).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                TextButton.icon(
                  icon: Icon(Icons.calendar_today_outlined),
                  onPressed: () {
                    selectPickUpDate(contx);
                  },
                  label: Text("Select Date"),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Select Time",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  createTextField("From", () {
                    selectFromPickUpTime(contx);
                  }, pickUpFromTime),
                  SizedBox(
                    width: 30,
                  ),
                  createTextField("To", () {
                    selectToPickUpTime(contx);
                  }, pickUpToTime),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: checkFieldsStatus()
                    ? () async {
                        setState(() {
                          isLoading = true;
                        });
                        await Provider.of<YourOrderProvider>(contx,
                                listen: false)
                            .activateYourOrder(
                                yourOrderId: widget.yourOrderId,
                                pickUpDate: pickUpDate,
                                pickUpFromTime: pickUpFromTime,
                                pickUpToTime: pickUpToTime);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();
                      }
                    : null,
                child: Text("Activate Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
