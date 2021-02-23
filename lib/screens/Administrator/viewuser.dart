import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Services/firebaseservices.dart';
import 'dart:math';

class UserActivity extends StatefulWidget {
  @override
  _UserActivityState createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  List winners;

  bool loader = true;
  var sharedtotalA;
  var fasttotalA;
  var sharedtotalB;
  var fasttotalB;
  var fasttotalC;
  var sharedtotalC;
  var sharedtotalD;
  var fasttotalD;
  var sharedtotalE;
  var fasttotalE;
  var sharedtotalF;
  var fasttotalF;
  var fasttotalG;
  var sharedtotalG;
  var fasttotalH;
  var sharedtotalH;
  var totalA;
  var totalB;
  var totalC;
  var totalD;
  var totalE;
  var totalF;
  var totalG;
  var totalH;
  var totalShared;
  var totalFast;
  var totalOrders;
  // getwinners() {
  //   var totalA = sharedtotalA + fasttotalA;

  //   winners.add(totalA);
  //   winners.add(totalB);
  //   winners.add(totalC);
  //   winners.add(totalD);
  //   winners.add(totalE);
  //   winners.add(totalF);
  //   winners.add(totalG);
  //   winners.add(totalH);
  //   setState(() {
  //     winners.sort();
  //     winner1 = winners.first;
  //   });
  // }

  void getAnalytics() async {
    //A
    final QuerySnapshot aSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot A')
        .get();
    final int sharedordersA = aSnap.docs.length;
    final QuerySnapshot aaSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot A')
        .get();
    final int fastdordersA = aaSnap.docs.length;
    // B
    final QuerySnapshot bSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot B')
        .get();
    final int sharedordersB = bSnap.docs.length;
    final QuerySnapshot bbSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot B')
        .get();
    final int fastdordersB = bbSnap.docs.length;
    //C
    final QuerySnapshot cSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot C')
        .get();
    final int sharedordersC = cSnap.docs.length;
    final QuerySnapshot ccSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot C')
        .get();
    final int fastdordersC = ccSnap.docs.length;

    //D
    final QuerySnapshot dSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'DepotD')
        .get();
    final int sharedordersD = dSnap.docs.length;
    final QuerySnapshot ddSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot D')
        .get();
    final int fastdordersD = ddSnap.docs.length;
    //E
    final QuerySnapshot eSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot E')
        .get();
    final int sharedordersE = eSnap.docs.length;
    final QuerySnapshot eeSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot E')
        .get();
    final int fastdordersE = eeSnap.docs.length;
    //F
    final QuerySnapshot fSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot F')
        .get();
    final int sharedordersF = fSnap.docs.length;
    final QuerySnapshot ffSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot F')
        .get();
    final int fastdordersF = ffSnap.docs.length;
    // G
    final QuerySnapshot gSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot G')
        .get();
    final int sharedordersG = gSnap.docs.length;
    final QuerySnapshot ggSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot G')
        .get();
    final int fastdordersG = ggSnap.docs.length;
    //H
    final QuerySnapshot hSnap = await FirebaseFirestore.instance
        .collection('sharedorders')
        .where('depotname', isEqualTo: 'Depot H')
        .get();
    final int sharedordersH = hSnap.docs.length;
    final QuerySnapshot hhSnap = await FirebaseFirestore.instance
        .collection('fastorders')
        .where('depotname', isEqualTo: 'Depot H')
        .get();
    final int fastdordersH = hhSnap.docs.length;
    //
    setState(() {
      sharedtotalA = sharedordersA;
      fasttotalA = fastdordersA;
      sharedtotalB = sharedordersB;
      fasttotalB = fastdordersB;
      fasttotalC = fastdordersC;
      sharedtotalC = sharedordersC;
      fasttotalD = fastdordersD;
      sharedtotalD = sharedordersD;
      fasttotalE = fastdordersE;
      sharedtotalE = sharedordersE;
      fasttotalF = fastdordersF;
      sharedtotalF = sharedordersF;
      fasttotalG = fastdordersG;
      sharedtotalG = sharedordersG;
      fasttotalH = fastdordersH;
      sharedtotalH = sharedordersH;
      totalA = sharedtotalA + fasttotalA;
      totalB = sharedtotalB + fasttotalB;
      totalC = sharedtotalC + fasttotalC;
      totalD = sharedtotalD + fasttotalD;
      totalE = sharedtotalE + fasttotalE;
      totalF = sharedtotalF + fasttotalF;
      totalG = sharedtotalG + fasttotalG;
      totalH = sharedtotalH + fasttotalH;
      totalShared = sharedtotalA +
          sharedtotalB +
          sharedtotalC +
          sharedtotalD +
          sharedtotalE +
          sharedtotalF +
          sharedtotalG +
          sharedtotalH;
      totalFast = fasttotalA +
          fasttotalB +
          fasttotalC +
          fasttotalD +
          fasttotalE +
          fasttotalF +
          fasttotalG +
          fasttotalH;
      totalOrders = totalFast + totalShared;
      loader = false;
      // getwinners();
    });
  }

  @override
  void initState() {
    getAnalytics();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: loader == false
          ? ListView(
              children: [
                Container(
                    child: Column(
                  children: [
                    // Container(
                    //   height: 170,
                    //   child: Card(
                    //     child: Column(
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text('Depot with highest orders '),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text('one'),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text('Depot B (4)'),
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.all(8.0),
                    //           child: Text('Depot B (3)'),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 5,
                    ),
                    DataTable(columns: [
                      DataColumn(label: Text('Depots')),
                      DataColumn(label: Text('Fast')),
                      DataColumn(label: Text('Shared')),
                      DataColumn(label: Text('Total')),
                    ], rows: [
                      DataRow(cells: [
                        DataCell(Text('A')),
                        DataCell(Text(fasttotalA.toString())),
                        DataCell(Text(sharedtotalA.toString())),
                        DataCell(Text(totalA.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('B')),
                        DataCell(Text(fasttotalB.toString())),
                        DataCell(Text(sharedtotalB.toString())),
                        DataCell(Text(totalB.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('C')),
                        DataCell(Text(fasttotalC.toString())),
                        DataCell(Text(sharedtotalC.toString())),
                        DataCell(Text(totalC.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('D')),
                        DataCell(Text(fasttotalD.toString())),
                        DataCell(Text(sharedtotalD.toString())),
                        DataCell(Text(totalD.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('E')),
                        DataCell(Text(fasttotalE.toString())),
                        DataCell(Text(sharedtotalE.toString())),
                        DataCell(Text(totalE.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('F')),
                        DataCell(Text(fasttotalF.toString())),
                        DataCell(Text(sharedtotalF.toString())),
                        DataCell(Text(totalF.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('G')),
                        DataCell(Text(fasttotalG.toString())),
                        DataCell(Text(sharedtotalG.toString())),
                        DataCell(Text(totalG.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('H')),
                        DataCell(Text(fasttotalH.toString())),
                        DataCell(Text(sharedtotalH.toString())),
                        DataCell(Text(totalH.toString())),
                      ]),
                      DataRow(cells: [
                        DataCell(Text('Total',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                        DataCell(Text(totalFast.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                        DataCell(Text(totalShared.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                        DataCell(Text(totalOrders.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold))),
                      ]),
                    ])
                  ],
                )),
              ],
            )
          : Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
    );
  }
}
