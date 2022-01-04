import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final int phoneNo;
  final String email;
  final String password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
    required this.email,
    required this.password,
  });
}

class UserProvider with ChangeNotifier {
  var _user = User(
      id: Uuid().v4(),
      firstName: "Shaun",
      lastName: "Shah",
      phoneNo: 9879115776,
      email: "KajiwalaShaurya29@gmail.com",
      password: 'shaunpur');

  User getUser() {
    return _user;
  }
}
