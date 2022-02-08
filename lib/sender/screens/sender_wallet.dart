import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/sender/widgets/add_money.dart';

import 'package:wecare_logistics/sender/widgets/sender_appbar.dart';
import 'package:wecare_logistics/sender/widgets/sender_lasttransactions.dart';

/*   color: Color.fromRGBO(46, 157, 255, 1), */
class SenderWallet extends StatelessWidget {
  static final String senderWalletRoute = '/SenderWalletRoute';

  @override
  Widget build(BuildContext contx) {
    var userWalletBalance = Provider.of<UserProvider>(contx).getWalletBalance;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: SenderAppBar(
          barTitle: "Wallet",
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "\u{20B9} $userWalletBalance",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text("Wallet Balance"),
                    ],
                  ),
                  Container(
                    width: 200,
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        AddMoneyDialogBox(contx);
                      },
                      child: Text("Add Money"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  width: double.infinity,
                  color: Colors.amber.shade300,
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        child: Text(
                          "Last Transactions (3)",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (contx, index) {
                            return SenderLastTransactionsWidget();
                          },
                          itemCount: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
