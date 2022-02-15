import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/models/transaction_model.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/sender/widgets/add_money.dart';

import 'package:wecare_logistics/sender/widgets/sender_appbar.dart';
import 'package:wecare_logistics/sender/widgets/sender_lasttransactions.dart';

/*   color: Color.fromRGBO(46, 157, 255, 1), */
class SenderWallet extends StatefulWidget {
  static final String senderWalletRoute = '/SenderWalletRoute';

  @override
  _SenderWalletState createState() => _SenderWalletState();
}

class _SenderWalletState extends State<SenderWallet> {
  bool init = true;
  bool isLoading = false;
  @override
  void didChangeDependencies() async {
    if (init) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactions();
      setState(() {
        isLoading = false;
      });
      init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    var userWalletBalance = Provider.of<UserProvider>(contx).getWalletBalance;
    List<Transcation> transactionList =
        Provider.of<TransactionProvider>(contx).getTransactionList;
    /* var Transaction = Provider.of<TransactionProvider>(contx) */
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
                        "\u{20B9}$userWalletBalance",
                        style: TextStyle(
                          fontSize: 30,
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
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (contx, index) {
                                  return SenderLastTransactionsWidget(
                                    courierName:
                                        transactionList[index].courierName,
                                    transactionDate:
                                        transactionList[index].transactionDate,
                                    transactionAmount: transactionList[index]
                                        .transactionAmount,
                                  );
                                },
                                itemCount: transactionList.length,
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
