import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CreateOrderScreen extends StatefulWidget {
  static const String createOrderScreenRoute = "/CreateOrderScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return CreateOrderScreenState();
  }
}

class CreateOrderScreenState extends State<CreateOrderScreen> {
  var _form = GlobalKey<FormState>();
  var _isDateSelected = false;
  String? _selectedDate;

  var _pickUpFocus = FocusNode();
  var _reciverNameFocus = FocusNode();
  var _dropLocationFocus = FocusNode();
  var _deliveryPinCodeFocus = FocusNode();
  var _lengthFocus = FocusNode();
  var _breadthFocus = FocusNode();
  var _heightFocus = FocusNode();
  var _weightFocus = FocusNode();
  var _productTitleFocus = FocusNode();
  var _productCategoryFocus = FocusNode();
  var _productPriceFocus = FocusNode();
  var _quantityFocus = FocusNode();

  Future<void> opendDatePicker() async {
    var _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2023));

    if (_date != null) {
      setState(() {
        _selectedDate = DateFormat('d/M/y').format(_date);
        _isDateSelected = true;
      });
    } else {
      setState(() {
        _selectedDate = null;
        _isDateSelected = false;
      });
    }
  }

  Widget createTextFormField(
      {required BuildContext contx,
      required String label,
      TextInputType keyboard = TextInputType.text,
      required FocusNode focus,
      required FocusNode requestF,
      required String? Function(String?) funValidate}) {
    return TextFormField(
        autovalidateMode: AutovalidateMode.always,
        keyboardType: keyboard,
        textInputAction: TextInputAction.next,
        focusNode: focus,
        decoration: InputDecoration(labelText: label),
        onFieldSubmitted: (_) {
          Focus.of(contx).requestFocus(requestF);
        },
        validator: funValidate);
  }

  String? checkIsEmpty(String? value) {
    if (value!.isEmpty) {
      return "Empty Field!";
    }
    return null;
  }

  void onCreateOrder() {
    var validate = _form.currentState!.validate();

    if (!validate) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Error in Form"),
              content: Text("Please fill whole form"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Okay',
                  ),
                )
              ],
            );
          });
      return;
    }
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          title: Text(
            "Create Shipment",
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Delivery Details",
                  style: TextStyle(fontSize: 20),
                ),
                createTextFormField(
                  contx: contx,
                  label: "PickUpLocation",
                  focus: _pickUpFocus,
                  requestF: _reciverNameFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                createTextFormField(
                  contx: contx,
                  label: "Reciver Name",
                  focus: _reciverNameFocus,
                  requestF: _dropLocationFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                createTextFormField(
                  contx: contx,
                  label: "Drop Location",
                  focus: _dropLocationFocus,
                  requestF: _deliveryPinCodeFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                createTextFormField(
                  contx: contx,
                  keyboard: TextInputType.number,
                  label: "Delivery PinCode",
                  focus: _deliveryPinCodeFocus,
                  requestF: _lengthFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    if (value.length != 6) {
                      return "6 digits pins";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text(
                    "Order Details",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: createTextFormField(
                        contx: contx,
                        keyboard: TextInputType.number,
                        label: "L",
                        focus: _lengthFocus,
                        requestF: _breadthFocus,
                        funValidate: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          if (double.tryParse(value) == null ||
                              int.tryParse(value) == null) {
                            return "0";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: createTextFormField(
                        contx: contx,
                        keyboard: TextInputType.number,
                        label: "B",
                        focus: _breadthFocus,
                        requestF: _heightFocus,
                        funValidate: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: createTextFormField(
                        contx: contx,
                        label: "H",
                        keyboard: TextInputType.number,
                        focus: _heightFocus,
                        requestF: _weightFocus,
                        funValidate: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                createTextFormField(
                  contx: contx,
                  keyboard: TextInputType.number,
                  label: "Weight(kg)",
                  focus: _weightFocus,
                  requestF: _productTitleFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                createTextFormField(
                  contx: contx,
                  label: "Product Title",
                  focus: _productTitleFocus,
                  requestF: _productCategoryFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                createTextFormField(
                  contx: contx,
                  label: "Product Category",
                  focus: _productCategoryFocus,
                  requestF: _productPriceFocus,
                  funValidate: (value) {
                    if (value!.isEmpty) {
                      return "Empty Field!";
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: createTextFormField(
                        contx: contx,
                        keyboard: TextInputType.number,
                        label: "Prd.price",
                        focus: _productPriceFocus,
                        requestF: _quantityFocus,
                        funValidate: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("X"),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.always,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        focusNode: _quantityFocus,
                        decoration: InputDecoration(labelText: "Qyt"),
                        onFieldSubmitted: (_) {
                          opendDatePicker();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("="),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(labelText: "Total"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: _isDateSelected
                            ? Text(
                                _selectedDate as String,
                                style: TextStyle(
                                  color: Theme.of(contx).primaryColor,
                                  fontSize: 15,
                                ),
                              )
                            : Text("No delivery date selected "),
                        trailing: TextButton(
                          onPressed: () {
                            opendDatePicker();
                          },
                          child: Text("Select Date"),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      onCreateOrder();
                    },
                    child: Text("Create Order"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
