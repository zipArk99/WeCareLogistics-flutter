import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String id;
  String? tokenId;
  DateTime? expiresIn;
  final String email;
  final String password;
  double walletBalance;

  User(
      {required this.id,
      required this.email,
      required this.password,
      this.walletBalance = 0.0});
/*   final String tokenId;
  final String token_expire;
  final String user_role; */

  /* void signUpUser(String email,String password){
       this.id=Uuid().v4();
       this.email=email;
       this.password=password;
  }

  String getuserId(){
    return id as String;
  }

  String getUserEmail(){
    return email as String;
  }
  
  void registration() {}
  void updateProfile() {}
  void login() {}
  void logout() {}
  void forgotPassword() {} */

}

class UserProvider with ChangeNotifier {
  String userFirstName = '';
  String userLastName = '';
  int userPhoneNo = 0;
  String id = '';
  String tokenId = '';
  DateTime? expiresIn;
  String userEmail = '';
  String userPassword = '';
  String userRole = '';
  double walletBalance = 0.0;

  var _courierServiceUser1 = User(
      id: "dsa45556",
      email: "KajiwalaShaurya29@gmail.com",
      password: 'shaunpur');
  var _senderUser2 = User(
    id: "789poip",
    email: "KajiwalaShaurya123@gmail.com",
    password: 'shaun',
  );

  var _courierServiceUser2 = User(
    id: "ds6466ff",
    email: "raj123@gmail.com",
    password: 'Raj',
  );

  User getUser() {
    return _courierServiceUser1;
  }

  User getSenderUser2() {
    return _senderUser2;
  }

  void transferAmount(double amount) {
    _courierServiceUser1.walletBalance += amount;
    _senderUser2.walletBalance -= amount;
  }

  Future<void> registerUser(
      {String email = "",
      String password = "",
      String firstName = "",
      String lastName = "",
      int phoneNo = 0,
      String method = ""}) async {
    await authentication(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNo: phoneNo,
        method: "signUp");
  }

  Future<void> signInUser(
      {String email = "",
      String password = "",
      String firstName = "",
      String lastName = "",
      int phoneNo = 0,
      String method = ""}) async {
    await authentication(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNo: phoneNo,
        method: "signInWithPassword");
  }

  Future<bool> authentication(
      {String email = "",
      String password = "",
      String firstName = "",
      String lastName = "",
      int phoneNo = 0,
      String method = ""}) async {
    try {
      var url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:$method?key=AIzaSyAFxm0aaFIah1V1agFRi-49b9fU_XRYhic');

      var response = await http.post(
        url,
        body: json.encode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );

      if (response.statusCode >= 400) {
        print(response.body);
        print("error caught status code::" + response.statusCode.toString());
        return false;
      }
      var decodedJsonString =
          json.decode(response.body) as Map<String, dynamic>;

      tokenId = decodedJsonString['idToken'];
      id = decodedJsonString['localId'];
      expiresIn = DateTime.now().add(
        Duration(
          seconds: int.parse(
            decodedJsonString['expiresIn'],
          ),
        ),
      );
      userEmail = decodedJsonString['email'];

      if (method == "signUp") {
        url = Uri.https(
            'logistics-87e01-default-rtdb.firebaseio.com', '/users/$id.json');

        var userResponse = await http.put(url,
            body: json.encode({
              'firstName': firstName,
              'lastName': lastName,
              'phoneNo': phoneNo,
              'email': email,
              'walletBalance': walletBalance,
            }));
        if (userResponse.statusCode >= 400) {
          print(response.body);
          print("Error caught status code::" +
              userResponse.statusCode.toString());
          return false;
        }
      } else {
        url = Uri.https(
            'logistics-87e01-default-rtdb.firebaseio.com', '/users/$id.json');

        var response = await http.get(url);

        decodedJsonString = json.decode(response.body) as Map<String, dynamic>;
        userFirstName = decodedJsonString['firstName'];
        userLastName = decodedJsonString['lastName'];
        userPhoneNo = decodedJsonString['phoneNo'];
        userRole = decodedJsonString['userRole'];
        walletBalance = decodedJsonString['walletBalance'];

        if (response.statusCode >= 400) {
          print("Error occured in login::" + response.statusCode.toString());
          return false;
        }

        print('phone no ::' + userPhoneNo.toString());
      }

      print(response.body);
    } catch (error) {
      print(error);
    }
    return true;
  }

  /*---- Assigning user it's role---- */
  Future<void> addUserRole(String role) async {
    try {
      var url = Uri.https(
          'logistics-87e01-default-rtdb.firebaseio.com', 'users/$id.json');
      var response = await http.patch(
        url,
        body: json.encode(
          {
            'userRole': role,
          },
        ),
      );

      if (response.statusCode >= 400) {
        return;
      } else {
        userRole = role;
      }
    } catch (error) {
      print("Error found::" + error.toString());
    }
  }
}
