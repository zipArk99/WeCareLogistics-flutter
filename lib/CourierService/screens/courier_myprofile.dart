import 'package:flutter/material.dart';
import 'package:wecare_logistics/CourierService/drawer/courier_drawer.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_appbar.dart';
import 'package:wecare_logistics/CourierService/widgets/courier_review.dart';

class CourierMyProfile extends StatelessWidget {
  static const String courierMyProfileRoute = "/CourierMyProfileRoute";

  List<Map<String, dynamic>> rating = [
    {'name': 'shaurya kajwala', 'rate': 3.0},
    {'name': 'John Don', 'rate': 4.0},
  ];

  Widget myProfileImpDetails(String heading, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(title),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      drawer: CourierDrawer(),
      appBar: PreferredSize(
        child: CourierAppBar(
          barTitle: "My Profile",
        ),
        preferredSize: Size.fromHeight(80),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: double.infinity,
                child: Card(
                  color: Theme.of(contx).primaryColorLight,
                  elevation: 10,
                  child: Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 3,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(13),
                                child: Text(
                                  "Anjani Couriers",
                                  style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              myProfileImpDetails("Experience", "5 Years"),
                              myProfileImpDetails("Branch", "2"),
                              myProfileImpDetails("Based", "Ahmedabad"),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        flex: 2,
                        child: Column(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      height: 150,
                      child: Card(
                        color: Theme.of(contx).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "17",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(contx).primaryColorDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: Container(
                      height: 150,
                      child: Card(
                        color: Theme.of(contx).accentColor,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Text(
                                "\$500",
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Theme.of(contx).primaryColorDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Text(
                                "Earned",
                                style: TextStyle(fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 30, bottom: 10, right: 10),
                child: Text(
                  "Reviews(32)",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListView.builder(
                primary: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (contx, index) {
                  return CourierReview(
                    name: rating[index]['name'],
                    rate: rating[index]['rate'],
                  );
                },
                itemCount: rating.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
