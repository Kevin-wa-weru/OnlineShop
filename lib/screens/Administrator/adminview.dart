import 'package:flutter/material.dart';
import 'pie_chart_page.dart';
import 'updateorder.dart';
import 'todaysdelivery.dart';
import 'deliveryforadeport.dart';
import 'viewuser.dart';
import '../Administrator/revenue.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Administator"),
        ),
        body: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateOrder(),
                    ));
              },
              child: Container(
                  height: 50,
                  child: Card(
                    elevation: 15,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Update arrived order \n",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodayDelivery(),
                    ));
              },
              child: Container(
                  height: 50,
                  child: Card(
                    elevation: 15,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View today’s deliveries. \n",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserActivity(),
                    ));
              },
              child: Container(
                  height: 50,
                  child: Card(
                    elevation: 15,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View Orders reports",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Revenue(),
                    ));
                // Revenue(),
              },
              child: Container(
                  height: 50,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "View Revenue reports \n",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }
}
