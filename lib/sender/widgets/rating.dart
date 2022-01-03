import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Rating extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RatingState();
  }
}

class _RatingState extends State<Rating> {
  var _form = GlobalKey<FormState>();
  double? _rate = 0.0;
  TextEditingController _ratingDescription = TextEditingController();

  @override
  Widget build(BuildContext contx) {
    return Dialog(
      child: Container(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.amber.shade200,
              child: Text(
                "Rating",
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(contx).primaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RatingBar.builder(
                    itemBuilder: (contx, _) {
                      return Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (value) {
                      setState(() {
                        _rate = value;
                      });
                    },
                    unratedColor: Colors.grey,
                    initialRating: 1,
                    itemCount: 5,
                    maxRating: 5,
                    minRating: 1,
                    allowHalfRating: false,
                    updateOnDrag: true,
                  ),
                  Text(
                    _rate.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(contx).primaryColor,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _form,
                child: TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                  controller: _ratingDescription,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Rate It",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            Container(
              color: Colors.amber.shade200,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    child: Image.network(
                      'https://play-lh.googleusercontent.com/YtXTsa-6SaaMl02-OUo8iRztlX5Thu4aCLavunIV1M5hm9y4ySTPpMjpY44fL4ayz7Se',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Chandu Couriers",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
