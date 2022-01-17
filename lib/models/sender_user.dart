import 'package:wecare_logistics/models/user.dart';

class SenderUser extends User {
  final double walletBalance;

  SenderUser({required String firstName, required this.walletBalance})
      : super(firstName: firstName);
}
