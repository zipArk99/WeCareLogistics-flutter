import 'package:flutter/material.dart';

class OrdersWidget extends StatelessWidget {
  @override
  Widget build(BuildContext contx) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.amber,
            radius: 30,
            child: Text("#12e"),
          ),
          title: Text("SmartPhone"),
          subtitle: Text("Ahmedabad-->Surat"),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}
