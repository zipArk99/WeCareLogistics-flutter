import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShowActivateDialogBox {
  BuildContext contx;
  ShowActivateDialogBox({required this.contx}) {
    showDialog(
        context: contx,
        builder: (contx) {
          return ActivateYourOrder();
        });
  }
}

class ActivateYourOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ActivateYourOrderState();
  }
}

class ActivateYourOrderState extends State<ActivateYourOrder> {
  late String pickUpDate = '';
  late String pickUpFromTime = 'From';
  late String pickUpToTime = 'To';

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

  void selectToPickUpTime(BuildContext contx) async {
    var toTime = await showTimePicker(
      context: contx,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );

    if (toTime != null) {
      setState(() {
        print("inside date");
        pickUpToTime = toTime.toString();
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
        height: 40,
        child: TextFormField(
          initialValue: value,
          readOnly: true,
          onTap: fun,
          decoration: InputDecoration(
            hintText: value,
            prefixIcon: Icon(Icons.av_timer_rounded),
            labelStyle: TextStyle(
              fontSize: 11,
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
                            fontSize: 20,
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
                onPressed: () {},
                child: Text("Activate Order"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
