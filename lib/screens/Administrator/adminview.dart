import 'package:flutter/material.dart';
import 'pie_chart_page.dart';
import 'updateorder.dart';
import 'todaysdelivery.dart';
import 'deliveryforadeport.dart';
import 'viewuser.dart';
import '../Administrator/revenue.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../sign_in/sign_in_screen.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  var totalfastpay = 0;
  var totalsharedpay = 0;
  var apprevenue = 0;
  var fastpercent;
  var sharedpercent;
  getAnalysis() async {
    // setState(() {
    //   loader = true;
    //   // chartloader = true;
    // });

    FirebaseFirestore.instance
        .collection('sharedorders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc["TotalPaid"]);
                var ty = doc["TotalPaid"];
                setState(() {
                  totalfastpay = totalfastpay + ty;
                  apprevenue = totalfastpay + totalsharedpay;
                  getpercent();
                  // fastpercent = totalfastpay / apprevenue * 100;
                  // sharedpercent = totalsharedpay / apprevenue * 100;
                });

                // var _lister = doc["TotalPaid"].toList();
                // print(_lister.toString());
                // // var _list = puffy.values.toList();
                // fast.add(value)
              })
            });
    FirebaseFirestore.instance
        .collection('fastorders')
        .get()
        .then((QuerySnapshot querySnapshot) => {
              querySnapshot.docs.forEach((doc) {
                print(doc["TotalPaid"]);
                var dy = doc["TotalPaid"];
                setState(() {
                  totalsharedpay = totalsharedpay + dy;
                  apprevenue = totalfastpay + totalsharedpay;
                  getpercent();
                });
              })
            });
    setState(() {
      // getpercent();
      PieData.data.add(
        Data(name: 'Shared Orders', percent: sharedpercent, color: Colors.red),
      );
      PieData.data.add(
        Data(name: 'Fast Orders', percent: 25, color: const Color(0xff13d38e)),
      );
    });
  }

  Future getpercent() {
    setState(() {
      fastpercent = totalfastpay / apprevenue * 100;
      sharedpercent = totalsharedpay / apprevenue * 100;
      print('FPercent' + fastpercent.toString());
    });

    setState(() {});
  }

  @override
  void initState() {
    getAnalysis();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        SizedBox(
          height: 30,
        ),
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
                  builder: (context) => Revenue(
                    fpercent: fastpercent.toStringAsFixed(2),
                    spercent: sharedpercent.toStringAsFixed(2),
                    stotal: totalsharedpay,
                    ftotal: totalfastpay,
                    apprevenue: apprevenue,
                  ),
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
        SizedBox(
          height: 100,
        ),
        GestureDetector(
          onTap: () {
            FirebaseAuth.instance.signOut();

            // SignInScreen();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen(),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "Sign Out",
                style: TextStyle(color: Colors.deepOrange),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
