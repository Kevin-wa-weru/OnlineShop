import 'package:flutter/material.dart';
import 'custominput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truncate/truncate.dart';

class Updater extends StatefulWidget {
  final List<DocumentSnapshot> p_list;
  final int index;
  final text;
  const Updater({Key key, this.p_list, this.index, this.text})
      : super(key: key);

  @override
  _UpdaterState createState() => _UpdaterState();
}

class _UpdaterState extends State<Updater> {
  bool isFixed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onTap: () {
                setState(() {
                  isFixed = !isFixed;
                });
              },
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "orders",
                    style: TextStyle(color: Colors.green),
                  ))),
        ),
        body: ListView(
          children: [
            buildColumn(),
            buildColumn2(),
          ],
        ));
  }

  Column buildColumn() {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('sharedorders')
                .where('email', isEqualTo: widget.text.toString())
                // .where('email', isEqualTo: widget.text.toString())
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
                      height: 200,
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
                                  'Active: ${document['Active']}',
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
                              GestureDetector(
                                  onTap: () {
                                    final CollectionReference _sharedordersRef =
                                        FirebaseFirestore.instance
                                            .collection("sharedorders");
                                    _sharedordersRef
                                        .doc(document.id)
                                        .update({'Active': 'no'});
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      document['Active'] == 'yes'
                                          ? 'Set this order as picked'
                                          : 'Package was Collected',
                                      style: new TextStyle(
                                          color: document['Active'] == 'yes'
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  )),
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

  Column buildColumn2() {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('fastorders')
                .where('email', isEqualTo: widget.text.toString())
                // .where('email', isEqualTo: widget.text.toString())
                // .orderBy('deliveryday', descending: true)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 270.0,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black45),
                  ),
                );
              } else {
                return Column(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Center(
                        child: Container(
                      height: 200,
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
                                  'Active: ${document['Active']}',
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
                              GestureDetector(
                                  onTap: () {
                                    final CollectionReference _sharedordersRef =
                                        FirebaseFirestore.instance
                                            .collection("fastorders");
                                    _sharedordersRef
                                        .doc(document.id)
                                        .update({'Active': 'no'});
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      document['Active'] == 'yes'
                                          ? 'Set this order as picked'
                                          : 'Package was Collected',
                                      style: new TextStyle(
                                          color: document['Active'] == 'yes'
                                              ? Colors.red
                                              : Colors.green),
                                    ),
                                  )),
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
