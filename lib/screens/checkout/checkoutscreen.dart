import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:shop_app/screens/payment/pay.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class CheckoutScreen extends StatefulWidget {
  static String routeName = "/CheckoutScreen";
  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int radiovalue;
  String radioValueSubmit;
  String selectedDepot;
  String _response = 'No answer';
  String _responses = 'No answer';
  bool _isLoading = false;
  String shippment;
  var Dmore;
  var DToken;
  var Dname;
  var Dababy;
  var DsharedUserId;
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'splitdeliverycost',
      options: HttpsCallableOptions(timeout: Duration(seconds: 50)));

  fetchPost() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'depotname': selectedDepot,
          'shippmenttype': radioValueSubmit,
          'deliveryday': '12/02/2021',
          'userid': 'USEdebbdjeb56',
        },
      );
      var puffy = result.data;
      var _list = puffy.values.toList();
      var _dtoken = _list[0];
      var _price = _list[1];

      setState(() {
        _response = _price;
        DToken = _dtoken;

        print('This is zezeze Device Tokenii' + _dtoken);
        _isLoading = false;
        if (_response == 'Similar Order has not been found ') {
          _dodis() async {
            setState(() {
              _isLoading = true;
            });
            final CollectionReference _depotsRef =
                FirebaseFirestore.instance.collection("depots");
            var atiwat = await _depotsRef.doc(selectedDepot).get();
            var puffy = atiwat.data();
            var _list = puffy.values.toList();
            var _dless = _list[1];
            var _dwat = int.parse(_dless);
            var _dmore = _dwat / 2;
            setState(() {
              Dmore = _dmore;
              _isLoading = false;
            });
            _hoMyDialog(
                'No User From Same depot has placed an order. Continue to Pay half of the fixed Price ($Dmore). In case a similar order is found,you will be notified and additional charges will not apply. Otherwise you will have to pay the rest of delivery fee ($Dmore)on delivery');
          }

          _dodis();
        } else {
          if (radioValueSubmit == 'CS') {
            var _shareduserid = _list[2];
            setState(() {
              DsharedUserId = _shareduserid;
            });
            _showDialog(
                'A similar Order Has Been Found. IF you continue your delivery fee will be halfed to : Ksh $_response');
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Payment(
                    text: _response,
                    text2: shippment,
                    text3: selectedDepot,
                  ),
                ));
          }
        }
      });
      // ignore: deprecated_member_use
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }

  fetchDeviceToken() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'depotname': selectedDepot,
          'shippmenttype': radioValueSubmit,
          'deliveryday': '12/02/2021',
          'userid': 'USEdebbdjeb56',
        },
      );
      print(result.data['response']);
      print(_user);
      setState(() {
        // _response = result.data.myData['response'];

        _responses = result.data['response'];
        print('Kevininininiiin:' + _responses.toString());
        _isLoading = false;
      });
      // ignore: deprecated_member_use
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }

  fetchHalfy() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{
          'depotname': selectedDepot,
          'shippmenttype': radioValueSubmit,
          'deliveryday': '12/02/2021',
          'userid': 'USEdebbdjeb56',
        },
      );
      print(result.data['response']);
      print(_user);
      setState(() {
        // _response = result.data.myData['response'];
        _responses = result.data['response'];
        print('Kevininininiiin:' + _responses.toString());
        _isLoading = false;
      });
      // ignore: deprecated_member_use
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }

  final CollectionReference _usersRef =
      FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;

  // ignore: unused_element
  Future _addToOrders() {
    return _usersRef
        .doc(_user.uid)
        .collection("Orders")
        .doc('Orders (ids)')
        .set({
      "Product Ids": ['product id', 'product id'],
      "Total Price Paid": "2400",
      "Date Of Purchase": "12/12/2020",
      "Depot name": selectedDepot,
      "Date Of Delivery": "14/12/2020",
      "Status Of Deliver": "Not Delivered",
      "Shippment Type": radioValueSubmit,
      "Success": ""
    });
  }

  void handleRadioChange(int value) {
    setState(() {
      radiovalue = value;
      if (radiovalue == 0) {
        print('CS');
        radioValueSubmit = 'CS';
        shippment = 'Cost Shairing';
      } else if (radiovalue == 1) {
        print('FD');
        radioValueSubmit = 'FD';
        shippment = 'Fast Delivery';
      } else {
        print('SP');
        radioValueSubmit = 'SP';
        shippment = 'Cost Shairing.';
      }
    });
  }

  var selectedCurrency, selectedType;
  final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();

  Future<void> _showMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Continue To Pay',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              onPressed: () {
                print(DToken);
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(
                        text: _response,
                        text2: shippment,
                        text3: selectedDepot,
                        text4: DToken,
                        text5: DsharedUserId,
                      ),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _hoMyDialog(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Continue To Pay',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
              onPressed: () async {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(
                        text: Dmore.round().toString(),
                        text2: shippment,
                        text3: selectedDepot,
                      ),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Container(
            //   alignment: Alignment.center,
            //   child: Text("Checking Out",
            //       style: TextStyle(
            //         color: Colors.black,
            //       )),
            // ),
            // actions: <Widget>[
            //   IconButton(
            //     icon: Icon(
            //       Icons.ac_unit,
            //       size: 20.0,
            //       color: Colors.black12,
            //     ),
            //     onPressed: null,
            //   ),
            // ],
            ),
        body: Form(
          key: _formKeyValue,
          // autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
              SizedBox(height: 20.0),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         new Text(
              //           '\Product Total : ksh ${Provider.of<PhotoMoto>(context, listen: false).totalcartprices}',
              //           style: new TextStyle(color: Colors.black54),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20.0),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Choose collection depot ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("depots")
                      .snapshots(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      const Text("Loading.....");
                    else {
                      List<DropdownMenuItem> currencyItems = [];
                      for (int i = 0; i < snapshot.data.docs.length; i++) {
                        DocumentSnapshot snap = snapshot.data.docs[i];
                        currencyItems.add(
                          DropdownMenuItem(
                            child: Text(
                              snap.id,
                              style: new TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            value: "${snap.id}",
                          ),
                        );
                      }

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.shop,
                              size: 25.0, color: Colors.deepOrange),
                          SizedBox(width: 5.0),
                          DropdownButton(
                            items: currencyItems,
                            onChanged: (depotValue) {
                              setState(() {
                                selectedDepot = depotValue;
                                radioValueSubmit = radioValueSubmit;
                              });
                            },
                            value: selectedDepot,
                            isExpanded: false,
                            hint: new Text("Choose Your Depot",
                                style: TextStyle(color: Colors.deepOrange)),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 40.0,
              ),
              Center(
                  child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 8.0),
                    child: Text(
                      'Choose shippment Plan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        new Radio<int>(
                            activeColor: Colors.deepOrange,
                            value: 0,
                            groupValue: radiovalue,
                            onChanged: handleRadioChange),
                        Flexible(
                          child: new Text(
                            'Cost share (This will take at most four days)',
                            style: new TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 0.0, top: 8.0, bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        new Radio<int>(
                            activeColor: Colors.deepOrange,
                            value: 1,
                            groupValue: radiovalue,
                            onChanged: handleRadioChange),
                        Flexible(
                          child: new Text(
                            'Fast delivery-ksh 300 (This will take one day)',
                            style: new TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 60.0, right: 60.0, top: 20.0, bottom: 20.0),
                    alignment: Alignment.center,
                    child: new RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color:
                          _isLoading == true ? Colors.white : Colors.deepOrange,
                      onPressed: () async {
                        if (selectedDepot == null) {
                          setState(() {
                            _showMyDialog('Select Your Depot');
                          });
                        } else if (radioValueSubmit == null) {
                          setState(() {
                            _showMyDialog('Select Your Shippment Plan');
                          });
                        } else {
                          await fetchPost();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Payment(
                          //         text: _response,
                          //         text2: shippment,
                          //       ),
                          //     ));
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => SearchTab(),
                          //     ));
                        }
                      },
                      child: Flexible(
                        child: new Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          child: _isLoading == true
                              ? Theme(
                                  data: Theme.of(context)
                                      .copyWith(accentColor: Colors.orange),
                                  child: new CircularProgressIndicator(),
                                )
                              : Text(
                                  "Proceed",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ));
  }
}

class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
    this.title = title;
    this.body = body;
    this.message = message;
  }
}
