import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const String signUpScreenRoute = "/SignUpScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  String? _firstName;
  String? _lastName;
  BigInt? _phoneNo;
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();

  var _lastNameFocus = FocusNode();
  var _phoneNoFocus = FocusNode();
  var _emailFocus = FocusNode();
  var _passwordFocus = FocusNode();

  void onSignUp(BuildContext contx) {
    var validateSignUpForm = _formKey.currentState!.validate();
    if (!validateSignUpForm) {
      return;
    }
    _formKey.currentState!.save();
    print("name::" + _firstName.toString());
    print("name::" + _lastName.toString());
    print("name::" + _phoneNo.toString());
    print("name::" + _email.toString());
    print("name::" + _password.toString());
  }

  Widget build(BuildContext contx) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(contx).size.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    alignment: Alignment.center,
                    child: Text(
                      "Create Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  Container(
                    height: 6,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(contx).primaryColor,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "FirstName",
                          ),
                          onFieldSubmitted: (_) {
                            Focus.of(contx).requestFocus(_lastNameFocus);
                          },
                          onSaved: (value) {
                            _firstName = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter FirstName";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "LastName",
                            ),
                            focusNode: _lastNameFocus,
                            onFieldSubmitted: (_) {
                              Focus.of(contx).requestFocus(_phoneNoFocus);
                            },
                            onSaved: (value) {
                              _lastName = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter LastName";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next),
                      )
                    ],
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "PhoneNo",
                      ),
                      onFieldSubmitted: (_) {
                        Focus.of(contx).requestFocus(_emailFocus);
                      },
                      onSaved: (value) {
                        _phoneNo = BigInt.parse(value as String);
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter PhoneNo";
                        }
                        if (value.length < 10) {
                          return "Wrong Input";
                        }
                        if (BigInt.tryParse(value) == null) {
                          return "Enter Digits 0-9";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next),
                  TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      focusNode: _emailFocus,
                      onFieldSubmitted: (_) {
                        Focus.of(contx).requestFocus(_passwordFocus);
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                    ),
                    focusNode: _passwordFocus,
                    textInputAction: TextInputAction.done,
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        onSignUp(contx);
                        FocusScope.of(contx).unfocus();
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.black,
                        width: 150,
                        height: 2,
                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Divider(),
                      ),
                      Text("Or"),
                      Container(
                          color: Colors.black,
                          width: 150,
                          height: 2,
                          margin: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Divider()),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            child: Image.asset(
                              "lib/assets/images/googleLogo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text("Sign Up With Google"),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text("Alreday have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.of(contx).pushReplacementNamed(
                                LoginPageScreen.loginPageScreenRoute);
                          },
                          child: Text(
                            "Login",
                          ))
                    ],
                  ),
                  Text("T&C")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
