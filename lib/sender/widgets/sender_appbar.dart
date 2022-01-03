import 'package:flutter/material.dart';

class SenderAppBar extends StatelessWidget {
  final String barTitle;
  final Color color;
  final IconData icon;

  SenderAppBar(
      {this.barTitle = "WeCare",
      this.color = Colors.indigo,
      this.icon = Icons.notifications_active});
  @override
  Widget build(BuildContext contx) {
    return AppBar(
      backgroundColor: color,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      title: Text(barTitle),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_balance_wallet_sharp),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_on_sharp)),
        )
      ],
    );
  }
}
