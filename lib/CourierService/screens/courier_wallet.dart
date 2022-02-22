import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_appbar.dart';
import 'package:wecare_logistics/models/transaction_model.dart';
import 'package:wecare_logistics/models/user.dart';
import 'package:wecare_logistics/sender/widgets/sender_lasttransactions.dart';

class CourierWallet extends StatefulWidget {
  static String courierWalletRoute = '/CourierWalletRoute';

  @override
  _CourierWalletState createState() => _CourierWalletState();
}

class _CourierWalletState extends State<CourierWallet> {
  bool isLoading = false;
  bool isInit = true;
  void didChangeDependencies() async {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<TransactionProvider>(context, listen: false)
          .fetchTransactions(false);
      setState(() {
        isLoading = false;
      });
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext contx) {
    var userWalletBalance = Provider.of<UserProvider>(contx).getWalletBalance;
    List<Transcation> transactionList =
        Provider.of<TransactionProvider>(contx).getTransactionList;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: CourierAppBar(
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
                      onPressed: () {},
                      child: Text("Withdraw Money"),
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
                                      transactionAmount: transactionList[index]
                                          .transactionAmount,
                                      transactionDate: transactionList[index]
                                          .transactionDate,
                                      isSender: false,
                                      senderName: 'Shaurya kaj');
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
