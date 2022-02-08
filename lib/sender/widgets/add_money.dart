import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/user.dart';

class AddMoneyDialogBox {
  AddMoneyDialogBox(BuildContext contx) {
    showDialog(
        builder: (contx) {
          return Dialog(
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: 320,
                child: AddMoneyWidget(),
              ),
            ),
          );
        },
        context: contx);
  }
}

class AddMoneyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddMoneyWidgetState();
  }
}

class AddMoneyWidgetState extends State<AddMoneyWidget> {
  TextEditingController amount = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  void onAddMoney() async {
    var validate = _formKey.currentState!.validate();

    if (!validate) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserProvider>(context, listen: false)
        .addWalletBalance(int.parse(amount.text));
    setState(() {
      isLoading = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext contx) {
    print("Amount::" + amount.text);
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Add Amount \nHere",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w300,
                  color: Theme.of(contx).primaryColor,
                ),
              ),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: amount,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter amount";
                    } else if (double.parse(value) <= 500) {
                      return "Enter amount greater then 500";
                    }
                    return null;
                  },
                  showCursor: true,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(contx).primaryColor,
                      fontWeight: FontWeight.w500),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: "Enter Amount",
                    prefixText: "\u{20B9}  ",
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ActionChip(
                      onPressed: () {
                        setState(() {
                          if (amount.text.isEmpty) {
                            amount.text = 0.toString();
                            print("inside if");
                          }
                          amount.text =
                              (int.parse(amount.text) + 1000).toString();
                        });
                      },
                      backgroundColor: Colors.green.shade100,
                      label: Text("+1000"),
                    ),
                    ActionChip(
                      onPressed: () {
                        setState(() {
                          if (amount.text.isEmpty) {
                            amount.text = 0.toString();
                            print("inside if");
                          }
                          amount.text =
                              (int.parse(amount.text) + 2000).toString();
                        });
                      },
                      backgroundColor: Colors.green.shade300,
                      label: Text("+2000"),
                    ),
                    ActionChip(
                      onPressed: () {
                        setState(() {
                          if (amount.text.isEmpty) {
                            amount.text = 0.toString();
                            print("inside if");
                          }
                          amount.text =
                              (int.parse(amount.text) + 5000).toString();
                        });
                      },
                      backgroundColor: Colors.green.shade500,
                      label: Text("+5000"),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      onAddMoney();
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(contx).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(contx).errorColor,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
