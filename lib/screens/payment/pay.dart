import 'package:flutter/material.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/Cart.dart';
import 'package:shop_app/screens/payment/finalprocess.dart';
import 'custominput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/firebaseservices.dart';
import 'package:intl/intl.dart';
import '../Administrator/updateorder.dart';

class Payment extends StatefulWidget {
  final String text;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  Payment(
      {Key key,
      @required this.text,
      this.text2,
      this.text3,
      this.text4,
      this.text5})
      : super(key: key);
  static String routeName = "/Payment";

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var totalCartValue = 0;
  List howdy;
  void getPricesOfProductsInCart() {
    Map<String, dynamic> productMap;
    FirebaseServices _firebaseServices = FirebaseServices();
    _firebaseServices.usersRef
        .doc(_firebaseServices.getUserId())
        .collection("Cart")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.data()['price']);
        var ty = doc.data()['price'];
        setState(() {
          totalCartValue = totalCartValue + ty;
          print(totalCartValue);
        });
      });
    });
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      setState(() {
        phoneToken = deviceToken;
      });
    });
  }

  User _user = FirebaseAuth.instance.currentUser;
  var phoneToken;
  final CollectionReference _sharedordersRef =
      FirebaseFirestore.instance.collection("sharedorders");
  final CollectionReference _fastordersRef =
      FirebaseFirestore.instance.collection("fastorders");
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection("Users");
  // ignore: missing_return
  Future _addToOrders() {
    var k = DateTime.now().day.toString();
    var y = DateTime.now().month.toString();
    var d = DateTime.now().year.toString();
    var t = DateTime.now().day + 3;
    var l = DateTime.now().day + 1;

    if (widget.text2 == 'Cost Shairing') {
      return _sharedordersRef.doc(_user.uid).set({
        'TotalPaid': _AmountBePaid(),
        'deliveryday': '$t/$y/$d',
        'depotname': widget.text3,
        'sharedstatus': 'false',
        'userid': _user.uid,
        'DeviceToken': phoneToken,
        'email': _user.email,
        'Active': 'yes',
      });
    } else if (widget.text2 == 'Fast Delivery') {
      return _fastordersRef.add({
        'TotalPaid': _AmountBePaid(),
        'deliveryday': '$l/$y/$d',
        'depotname': widget.text3,
        'userid': _user.uid,
        'DeviceToken': phoneToken,
        'email': _user.email,
        'Active': 'yes',
      });
    }
  }

  bool isLoading = false;
  DocumentReference paymentsRef;
  DocumentReference depositsRef;
  String _response = 'No answer';
  bool _initialized = false;
  bool _error = false;

  Future<void> updateAccount(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };
    paymentsRef.set({"info": "kevin receipt data goes here"});

    return paymentsRef
        .collection("deposit")
        .doc(_user.uid)
        .set(initData)
        .then((value) {
      print("Transaction initialized");
      setState(() {
        isLoading = false;
      });
    }).catchError((error) => print("failed to init transaction: $error"));
  }

  final CollectionReference _depositsRef =
      FirebaseFirestore.instance.collection("deposits");

  Future<void> updateDeposits(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
      'DeviceToken': phoneToken,
      'UserID': _user.uid,
    };
    paymentsRef.set({"info": "kevin receipt data goes here"});

    return _depositsRef.doc(mCheckoutRequestID).set(initData).then((value) {
      print("Transaction initialized");
      setState(() {
        isLoading = false;
      });
    }).catchError((error) => print("failed to init transaction: $error"));
  }

  Future<void> startPaymentProcessing({String phone, double amount}) async {
    setState(() {
      isLoading = true;
    });
    dynamic transactionInitialisation;
    try {
      transactionInitialisation = await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount,
          partyA: phone,
          partyB: "174379",
          callBackURL: Uri(
              scheme: "https",
              host: "us-central1-onlineshop-b593d.cloudfunctions.net",
              path: "paymentCallback"),
          accountReference: "Kevin Ecommerce",
          phoneNumber: phone,
          transactionDesc: "demo",
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          passKey:
              "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");
      var result = transactionInitialisation as Map<String, dynamic>;

      if (result.keys.contains("ResponseCode")) {
        String mResponseCode = result["ResponseCode"];
        print("Result Code:" + mResponseCode);
        if (mResponseCode == '0') {
          updateDeposits(result["CheckoutRequestID"]);
          updateAccount(result["CheckoutRequestID"]);
          // updateDeposits(result["CheckoutRequestID"]);
          // _addToOrders();
        }
      }
      print('Transaction Result:' + transactionInitialisation.toString());
      return transactionInitialisation;
    } catch (e) {
      print('Exception' + e.toString());
      setState(() {
        isLoading = false;
      });
    }
  }

  void initializeFlutterfire() async {
    try {
      //wait for firebase to initialize ad set '_initialized' state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      paymentsRef =
          FirebaseFirestore.instance.collection('payments').doc(_user.uid);
    } catch (e) {
      print(e.toString());
      //Set '_errror' state to treu if firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    getPricesOfProductsInCart();
    _getToken();
    initializeFlutterfire();
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    bool _initialized = false;
    Future<void> init() async {
      if (!_initialized) {
        _firebaseMessaging.requestNotificationPermissions();
        _firebaseMessaging.subscribeToTopic("AllPushNotifications");
        _firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage: $message");

            String key = message.keys.elementAt(0);

            print('BBBBBBBBBBBBBBBBBBB' + key);
            // if(message='')
            setState(() {
              _addToOrders();

              if (widget.text2 == 'Cost Shairing' && (widget.text4) != null) {
                Future _updateOrderOne() {
                  return _sharedordersRef
                      .doc(widget.text5)
                      .update({'sharedstatus': 'true'});
                }

                Future _updateOrderTwo() {
                  return _sharedordersRef
                      .doc(_user.uid)
                      .update({'sharedstatus': 'true'});
                }

                _updateOrderOne();
                _updateOrderTwo();
              }
              //  text: _response,
              //       text2: shippment,
              //       text3: selectedDepot,
              var _k = DateTime.now().day.toString();
              var _y = DateTime.now().month.toString();
              var _d = DateTime.now().year.toString();
              var _t = DateTime.now().day + 3;
              var _l = DateTime.now().day + 1;
              if (widget.text2 == 'Cost Shairing') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalScreen(
                        text: widget.text4,
                        text2: widget.text3,
                        text3: "$_t/$_y/$_d",
                      ),
                    ));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FinalScreen(
                        text: widget.text4,
                        text2: widget.text3,
                        text3: "$_l/$_y/$_d",
                      ),
                    ));
              }
            });
          },
          onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch: $message");
          },
          onResume: (Map<String, dynamic> message) async {
            print("onResume: $message");
          },
        );
        String token = await _firebaseMessaging.getToken();
        print("FirebaseMessaging token: $token");
        _initialized = true;
      }
    }

    init();
    super.initState();
  }

  // ignore: non_constant_identifier_names
  _AmountBePaid() {
    var ProductTotal =
        Provider.of<PhotoMoto>(context, listen: false).totalcartprices;
    var applicableShippmentCost = int.parse(widget.text);

    // ignore: non_constant_identifier_names
    //  ProductTotal + applicableShippmentCost
    var TotalAmountTobePaid = totalCartValue + applicableShippmentCost;
    // var TotalAmountTobePaid = 1.0;
    return TotalAmountTobePaid;
  }

  var _phoney = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                    child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/mpesa.png'),
                            fit: BoxFit.fitHeight),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        '\Product Total : ksh $totalCartValue.00',
                        style: new TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'Applied shipping fee (${widget.text2.toString()}) : Ksh ${widget.text}.00',
                        style: new TextStyle(color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 50.0, left: 8.0, right: 8.0),
                      child: new Text(
                        'total : Ksh ${_AmountBePaid()}.00',
                        style: new TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, bottom: 50.0, left: 8.0, right: 8.0),
                      child: new Text(
                        'Pay : Ksh 1.00 for test?',
                        style: new TextStyle(color: Colors.black26),
                      ),
                    ),
                    CustomInput(
                      hintText: "phone 254701...",
                      onChanged: (value) {
                        setState(() {
                          _phoney = value;
                        });
                      },
                      onSubmitted: (value) {
                        _phoney = value;
                        // _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    Center(
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: isLoading == true
                            ? Colors.white
                            : Colors.deepOrange,
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => UpdateOrder(),
                          //     ));
                          startPaymentProcessing(
                              //  _AmountBePaid();
                              phone: _phoney,
                              amount: 1.0);
                        },
                        child: Flexible(
                          child: new Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            child: isLoading == true
                                ? CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.orange),
                                  )
                                : Text(
                                    "Pay",
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
              ),
            ],
          ),
        ));
  }

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
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white12,
    elevation: 0,
  );
}
