import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wecare_logistics/models/api_url.dart';

class User with ChangeNotifier {
  String id;
  String? tokenId;
  DateTime? expiresIn;
  final String email;
  final String password;
  int walletBalance;

  User(
      {required this.id,
      required this.email,
      required this.password,
      this.walletBalance = 0});
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
  int walletBalance = 0;

  int get getWalletBalance {
    return walletBalance;
  }

  set setWalletBalance(int amount) {
    walletBalance = walletBalance + amount;
  }

  set minusWalletBalance(int amount) {
    walletBalance = walletBalance - amount;
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
        url = Uri.https('${Api.url}', '/users/$id.json');

        var userResponse = await http.put(url,
            body: json.encode({
              'firstName': firstName,
              'lastName': lastName,
              'phoneNo': phoneNo,
              'email': email,
              'walletBalance': this.walletBalance,
            }));
        if (userResponse.statusCode >= 400) {
          print(response.body);
          print("Error caught status code::" +
              userResponse.statusCode.toString());
          return false;
        }
      } else {
        url = Uri.https('${Api.url}', '/users/$id.json');

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
      print("error occured while logging::"+error.toString());
    }
    return true;
  }

  bool checkWalletBalance(double transactionAmount) {
    print("wallet balance::" + getWalletBalance.toString());
    if (getWalletBalance >= transactionAmount) {
      return true;
    }
    return false;
  }

  Future<void> addWalletBalance(int amount) async {
    try {
      var url = Uri.https('${Api.url}', 'users/$id.json');

      var response = await http.patch(
        url,
        body: json.encode(
          {
            'walletBalance': this.walletBalance + amount,
          },
        ),
      );

      if (response.statusCode >= 400) {
        print("Error occured in network call while adding money to wallet");
        return;
      }
      setWalletBalance = amount;
      notifyListeners();
    } catch (error) {
      print("error occured while add money to wallet");
    }
  }

  Future<int?> fetchCourierWalletBalance(String userId) async {
    try {
      var url = Uri.https('${Api.url}', 'users/$userId/walletBalance.json');

      var repsonse = await http.get(url);

      if (repsonse.statusCode >= 400) {
        print(
            "Network call error occured while fething courier wallet balance");
        return 0;
      }
      print("---courier service balance fetched successfully---");
      var walletBalance = json.decode(repsonse.body) as int;

      return walletBalance;
    } catch (error) {
      print("Error occured while fetching Courier Wallet Balance::" +
          error.toString());
    }
  }

  Future<void> walletTransaction(
      {required double amount, required String courierId}) async {
    try {
      var senderUrl = Uri.https('${Api.url}', 'users/$id.json');
      var courierUrl = Uri.https('${Api.url}', 'users/$courierId.json');
      await http.patch(
        senderUrl,
        body: json.encode(
          {'walletBalance': walletBalance - amount.toInt()},
        ),
      );

      minusWalletBalance = amount.toInt();
      int courierWalletBalance =
          await fetchCourierWalletBalance(courierId) as int;

      await http.patch(
        courierUrl,
        body: json.encode(
          {
            'walletBalance': courierWalletBalance + amount.toInt(),
          },
        ),
      );
      notifyListeners();
    } catch (error) {
      print(
        "Error occured while debiting amount from wallet::" + error.toString(),
      );
    }
  }

  /*---- Assigning user it's role---- */
  Future<void> addUserRole(String role) async {
    try {
      var url = Uri.https('${Api.url}', 'users/$id.json');
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
