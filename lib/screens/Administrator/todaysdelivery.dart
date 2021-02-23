import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class TodayDelivery extends StatefulWidget {
  final List<DocumentSnapshot> p_list;
  final int index;
  final text;
  const TodayDelivery({Key key, this.p_list, this.index, this.text})
      : super(key: key);

  @override
  _TodayDeliveryState createState() => _TodayDeliveryState();
}

class _TodayDeliveryState extends State<TodayDelivery> {
// DateTime now = DateTime.now();
  var k = DateTime.now().day.toString();
  var y = DateTime.now().month.toString();
  var d = DateTime.now().year.toString();
  var t = DateTime.now().day + 2;
  bool showfield = false;
  var email;
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            buildColumn(),
            buildColumnOne(),
          ],
        ));
  }

  Column buildColumn() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder<QuerySnapshot>(
            future: load == false
                ? FirebaseFirestore.instance
                    .collection('sharedorders')
                    .where('deliveryday', isEqualTo: '$k/$y/$d')
                    // .orderBy('deliveryday', descending: true)
                    .get()
                : FirebaseFirestore.instance
                    .collection('sharedorders')
                    .where('deliveryday', isEqualTo: '$k/$y/$d')
                    .where('depotname', isEqualTo: email)
                    // .orderBy('deliveryday', descending: true)
                    .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 270.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                );
              } else {
                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Center(
                        child: Container(
                      height: 180,
                      width: 500,
                      child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  document['email'],
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Collection depot : ${document['depotname']}',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Order id : ${document.id}',
                                  style: new TextStyle(color: Colors.black12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Active',
                                  style: new TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )),
                    ));
                  }).toList(),
                );
              }
            }),
      ],
    );
  }

  Column buildColumnOne() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 10,
        ),
        FutureBuilder<QuerySnapshot>(
            future: load == false
                ? FirebaseFirestore.instance
                    .collection('fastorders')
                    .where('deliveryday', isEqualTo: '$k/$y/$d')
                    // .orderBy('deliveryday', descending: true)
                    .get()
                : FirebaseFirestore.instance
                    .collection('sharedorders')
                    .where('deliveryday', isEqualTo: '$k/$y/$d')
                    .where('depotname', isEqualTo: email)
                    // .orderBy('deliveryday', descending: true)
                    .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 270.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.deepOrange),
                  ),
                );
              } else {
                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Center(
                        child: Container(
                      height: 180,
                      width: 500,
                      child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  document['email'],
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Collection depot : ${document['depotname']}',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Order id : ${document.id}',
                                  style: new TextStyle(color: Colors.black12),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Active',
                                  style: new TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          )),
                    ));
                  }).toList(),
                );
              }
            }),
      ],
    );
  }
}
