import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/order_model.dart';
import 'package:wecare_logistics/sender/widgets/sender_appbar.dart';

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

  Order _newOrder = Order(
      senderId: "",
      orderId: "",
      orderTitle: "",
      productCategory: "",
      productQuantity: 0,
      productPrice: 0,
      orderLendth: 0,
      orderBreadth: 0,
      orderHeight: 0,
      orderWeight: 0,
      expectedDelivery: DateTime.now(),
      pickUpLocation: "",
      reciverName: "",
      dropLocation: "",
      orderCreatedOn: DateTime.now(),
      pinCode: 0);

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
        _selectedDate = "";
        _isDateSelected = false;
      });
    }
  }

  Widget createTextFormField({
    required BuildContext contx,
    required String label,
    TextInputType keyboard = TextInputType.text,
    required FocusNode focus,
    required FocusNode requestF,
    required String? Function(String?) funValidate,
    required Function(String?) funSave,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        keyboardType: keyboard,
        textInputAction: TextInputAction.next,
        focusNode: focus,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: label,
        ),
        onFieldSubmitted: (_) {
          Focus.of(contx).requestFocus(requestF);
        },
        validator: funValidate,
        onSaved: funSave,
      ),
    );
  }

  String? checkIsEmpty(String? value) {
    if (value!.isEmpty) {
      return "Empty Field!";
    }
    return null;
  }

  void onCreateOrder(BuildContext contx) {
    var validate = _form.currentState!.validate();

    if (!validate || !_isDateSelected) {
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

    _form.currentState!.save();

    Provider.of<OrdersProvider>(contx, listen: false)
        .addNewOrder(_newOrder, _selectedDate!);
    print(_newOrder.orderHeight);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext contx) {
    var orderProvider = Provider.of<OrdersProvider>(contx, listen: false);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SenderAppBar(barTitle: "Create Order"),
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
                    funSave: (value) {
                      _newOrder = orderProvider.copyWith(pickUpLocation: value);
                    }),
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: value);
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        dropLocation: value,
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: _newOrder.reciverName);
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        pinCode: int.parse(value as String),
                        dropLocation: _newOrder.dropLocation,
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: _newOrder.reciverName);
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
                          return null;
                        },
                        funSave: (value) {
                          _newOrder = orderProvider.copyWith(
                              orderLendth: double.parse(value as String),
                              pinCode: _newOrder.pinCode,
                              dropLocation: _newOrder.dropLocation,
                              pickUpLocation: _newOrder.pickUpLocation,
                              reciverName: _newOrder.reciverName);
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
                        funSave: (value) {
                          _newOrder = orderProvider.copyWith(
                              orderBreadth: double.parse(value as String),
                              orderLendth: _newOrder.orderLendth,
                              pinCode: _newOrder.pinCode,
                              dropLocation: _newOrder.dropLocation,
                              pickUpLocation: _newOrder.pickUpLocation,
                              reciverName: _newOrder.reciverName);
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
                        funSave: (value) {
                          _newOrder = orderProvider.copyWith(
                              orderHeight: double.parse(value as String),
                              orderBreadth: _newOrder.orderBreadth,
                              orderLendth: _newOrder.orderLendth,
                              pinCode: _newOrder.pinCode,
                              dropLocation: _newOrder.dropLocation,
                              pickUpLocation: _newOrder.pickUpLocation,
                              reciverName: _newOrder.reciverName);
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        orderWeight: double.parse(value as String),
                        orderHeight: _newOrder.orderHeight,
                        orderBreadth: _newOrder.orderBreadth,
                        orderLendth: _newOrder.orderLendth,
                        pinCode: _newOrder.pinCode,
                        dropLocation: _newOrder.dropLocation,
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: _newOrder.reciverName);
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        orderTitle: value,
                        orderWeight: _newOrder.orderWeight,
                        orderHeight: _newOrder.orderHeight,
                        orderBreadth: _newOrder.orderBreadth,
                        orderLendth: _newOrder.orderLendth,
                        pinCode: _newOrder.pinCode,
                        dropLocation: _newOrder.dropLocation,
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: _newOrder.reciverName);
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
                  funSave: (value) {
                    _newOrder = orderProvider.copyWith(
                        productCategory: value,
                        orderTitle: _newOrder.orderTitle,
                        orderWeight: _newOrder.orderWeight,
                        orderHeight: _newOrder.orderHeight,
                        orderBreadth: _newOrder.orderBreadth,
                        orderLendth: _newOrder.orderLendth,
                        pinCode: _newOrder.pinCode,
                        dropLocation: _newOrder.dropLocation,
                        pickUpLocation: _newOrder.pickUpLocation,
                        reciverName: _newOrder.reciverName);
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
                        funSave: (value) {
                          _newOrder = orderProvider.copyWith(
                              productPrice: double.parse(value as String),
                              productCategory: _newOrder.productCategory,
                              orderTitle: _newOrder.orderTitle,
                              orderWeight: _newOrder.orderWeight,
                              orderHeight: _newOrder.orderHeight,
                              orderBreadth: _newOrder.orderBreadth,
                              orderLendth: _newOrder.orderLendth,
                              pinCode: _newOrder.pinCode,
                              dropLocation: _newOrder.dropLocation,
                              pickUpLocation: _newOrder.pickUpLocation,
                              reciverName: _newOrder.reciverName);
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
                        decoration: InputDecoration(
                          labelText: "Qyt",
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (_) {
                          opendDatePicker();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Empty Field!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _newOrder = orderProvider.copyWith(
                            productQuantity: int.parse(value as String),
                            productPrice: _newOrder.productPrice,
                            productCategory: _newOrder.productCategory,
                            orderTitle: _newOrder.orderTitle,
                            orderWeight: _newOrder.orderWeight,
                            orderHeight: _newOrder.orderHeight,
                            orderBreadth: _newOrder.orderBreadth,
                            orderLendth: _newOrder.orderLendth,
                            pinCode: _newOrder.pinCode,
                            dropLocation: _newOrder.dropLocation,
                            pickUpLocation: _newOrder.pickUpLocation,
                            reciverName: _newOrder.reciverName,
                          );
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
                      onCreateOrder(contx);
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
