import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/screens/login_screen.dart';
import 'package:wecare_logistics/screens/role_choice_screen.dart';

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
  int? _phoneNo;
  bool isLoading = false;
  bool _passwordVisibility = false;

  Map<String, String> userData = {
    'email': '',
    'password': '',
  };

  final GlobalKey<FormState> _formKey = GlobalKey();

  var _lastNameFocus = FocusNode();
  var _phoneNoFocus = FocusNode();
  var _emailFocus = FocusNode();
  var _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  void onSignUp() async {
    var validateSignUpForm = _formKey.currentState!.validate();
    if (!validateSignUpForm) {
      return;
    }
    _formKey.currentState!.save();
    print("name::" + _firstName.toString());
    print("name::" + _lastName.toString());
    print("name::" + _phoneNo.toString());
    setState(() {
      isLoading = true;
    });

    await Provider.of<UserProvider>(context, listen: false).registerUser(
      email: userData['email'].toString(),
      password: userData['password'].toString(),
      firstName: _firstName.toString(),
      lastName: _lastName.toString(),
      phoneNo: _phoneNo as int,
      method: "signUp",
    );

    Navigator.of(context)
        .pushReplacementNamed(RoleChoiceScreen.roleChoiceScreeRoute);
  }

  Widget build(BuildContext contx) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(contx).size.height),
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
                              _phoneNo = int.parse(value as String);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter PhoneNo";
                              }
                              if (value.length < 10) {
                                return "Wrong Input";
                              }
                              if (int.tryParse(value) == null) {
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
                            keyboardType: TextInputType.emailAddress,
                            focusNode: _emailFocus,
                            onFieldSubmitted: (_) {
                              Focus.of(contx).requestFocus(_passwordFocus);
                            },
                            onSaved: (value) {
                              userData['email'] = value!;
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
                            suffixIcon: IconButton(
                              icon: _passwordVisibility
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.black,
                                    ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisibility = !_passwordVisibility;
                                });
                              },
                            ),
                          ),
                          obscureText: !_passwordVisibility,
                          focusNode: _passwordFocus,
                          textInputAction: TextInputAction.done,
                          onSaved: (value) {
                            userData['password'] = value!;
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
                            onPressed: onSignUp,
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
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                child: Divider()),
                          ],
                        ),
                        Container(
                          height: 70,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () {},
                            icon: Container(
                              width: 50,
                              height: 50,
                              child: Image.asset(
                                "lib/assets/images/googleLogo.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                            label: Text(
                              "Sign In With Google",
                              style: TextStyle(
                                color: Colors.black87,
                              ),
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
