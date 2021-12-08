import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
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

  var _lastNameFocus = FocusNode();
  var _phoneNoFocus = FocusNode();
  var _emailFocus = FocusNode();
  var _passwordFocus = FocusNode();

  Widget build(BuildContext contx) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Form(
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
                    width: 300,
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
                      textInputAction: TextInputAction.next),
                  TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                      ),
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done),
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "SignUp",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: RaisedButton(
                      color: Colors.white,
                      onPressed: () {},
                      child: Text(
                        "Sign Up With Google",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Text("Alreday have an account?"),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Login",
                            style: TextStyle(fontSize: 20),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
