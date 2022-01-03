import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CourierReview extends StatefulWidget {
  String name;
  double rate;

  CourierReview({required this.name, required this.rate});

  @override
  _CourierReviewState createState() => _CourierReviewState();
}

class _CourierReviewState extends State<CourierReview> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext contx) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 50,
                ),
                title: Text(widget.name),
                subtitle: Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 25,
                      ignoreGestures: true,
                      initialRating: widget.rate,
                      itemBuilder: (contx, index) {
                        return Icon(
                          Icons.star,
                          color: Theme.of(contx).accentColor,
                        );
                      },
                      onRatingUpdate: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(widget.rate.toString()),
                    ),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  icon: isExpanded
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more),
                ),
              ),
              if (isExpanded)
                Divider(
                  thickness: 1,
                ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    child: Text(
                      "hello how are you i am doing all fine what is going in your country right now",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
