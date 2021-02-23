import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truncate/truncate.dart';
import '../sign_in/sign_in_screen.dart';

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
  User _user = FirebaseAuth.instance.currentUser;
  bool isFixed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.logout, color: Colors.black54),
              onPressed: () {
                _signOut() async {
                  FirebaseAuth.instance.signOut();

                  // SignInScreen();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ));
                }

                _signOut();
              },
            )
          ],
          title: GestureDetector(
              onTap: () {
                setState(() {
                  isFixed = !isFixed;
                });
              },
              child: Text(
                "orders",
                style: TextStyle(color: Colors.black54),
              )),
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
                .where('email', isEqualTo: _user.email)
                // .where('email', isEqualTo: widget.text.toString())
                // .orderBy('deliveryday', descending: true)
                .get(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  height: 290.0,
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
                      height: 320,
                      width: 500,
                      child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
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
                                  'Delivery-type: Shared Cost Delivery',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Collection date: ${document['deliveryday']}',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Paid: Ksh ${document['TotalPaid']}.00',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  document['Active'] == 'yes'
                                      ? 'This package is yet to be collected'
                                      : 'Package was Collected',
                                  style: new TextStyle(
                                      color: document['Active'] == 'yes'
                                          ? Colors.red
                                          : Colors.green),
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

  Column buildColumn2() {
    return Column(
      children: [
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('fastorders')
                .where('email', isEqualTo: _user.email)
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
                      height: 320,
                      width: 500,
                      child: Card(
                          elevation: 10,
                          child: Column(
                            children: [
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
                                  'Delivery-type: Fixed Cost Delivery',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Collection date: ${document['deliveryday']}',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  'Paid: Ksh ${document['TotalPaid']}.00',
                                  style: new TextStyle(color: Colors.black54),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Text(
                                  document['Active'] == 'yes'
                                      ? 'This package is yet to be collected'
                                      : 'Package was Collected',
                                  style: new TextStyle(
                                      color: document['Active'] == 'yes'
                                          ? Colors.red
                                          : Colors.green),
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
