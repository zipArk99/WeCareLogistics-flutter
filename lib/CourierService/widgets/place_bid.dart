import 'package:flutter/material.dart';

class BottomSheetWidget {
  void openPlaceBidBottomModelSheet(BuildContext contx) {
    showModalBottomSheet(
        context: contx,
        builder: (contx) {
          return PlaceBidBottomModelSheetWidget();
        });
  }
}

class PlaceBidBottomModelSheetWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlaceBidBottomModelSheetWidgetState();
  }
}

class PlaceBidBottomModelSheetWidgetState
    extends State<PlaceBidBottomModelSheetWidget> {
  Widget createTextFormField({required String label}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      child: TextFormField(
        decoration:
            InputDecoration(border: OutlineInputBorder(), labelText: label),
      ),
    );
  }

/*   void openShowBottem(BuildContext contx){ 
    op

  }

  PlaceBidBottomModelSheetWidget(
    
  ) */
  @override
  Widget build(BuildContext contx) {
    return Column(
      children: [
        createTextFormField(label: "Bid Price"),
      ],
    );
  }
}
