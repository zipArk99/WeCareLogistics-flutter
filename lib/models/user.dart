import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
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
}
