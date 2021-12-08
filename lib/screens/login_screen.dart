import 'package:flutter/material.dart';
import 'package:wecare_logistics/screens/signup_screen.dart';

class LoginPageScreen extends StatefulWidget {
  static const String loginPageScreenRoute = "/LoginPageScreenRoute";
  @override
  State<StatefulWidget> createState() {
    return LoginPageScreenState();
  }
}

class LoginPageScreenState extends State<LoginPageScreen> {
  String? _email;
  String? _password;

  bool _passwordVisibility = false;

  var _loginForm = GlobalKey<FormState>();
  var _passwordFocus = FocusNode();

  void saveLogin() {
    var loginFormValiadtion = _loginForm.currentState!.validate();
    if (!loginFormValiadtion) {
      return;
    }
    _loginForm.currentState!.save();
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _loginForm,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                alignment: Alignment.center,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 50),
                width: double.infinity,
                height: 6,
                color: Theme.of(contx).primaryColor,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                    onSaved: (value) {
                      _email = value;
                    },
                    onFieldSubmitted: (_) {
                      Focus.of(contx).requestFocus(_passwordFocus);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Field!";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    focusNode: _passwordFocus,
                    obscureText: !_passwordVisibility,
                    autocorrect: false,
                    decoration: InputDecoration(
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
                      labelText: "Password",
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (value) {
                      _password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Empty Field!";
                      }
                      return null;
                    },
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Theme.of(contx).errorColor,
                      ),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        saveLogin();
                        FocusScope.of(contx).unfocus();
                      },
                      child: Text("Sign in"),
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Sign In With Google",
                        style: TextStyle(
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(contx)
                          .pushReplacementNamed(SignUpScreen.signUpScreenRoute);
                    },
                    child: Text("Sign Up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
