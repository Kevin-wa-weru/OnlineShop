import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

class PayComplete extends StatefulWidget {
  static String routeName = "/PayComplete";
  @override
  _PayCompleteState createState() => _PayCompleteState();
}

class _PayCompleteState extends State<PayComplete> {
  DocumentReference paymentsRef;
  String mUserMail = "kevinmwangi7881@gmail.com";
  int mCurrentAccountBalance = 0;
  //Set default '_initialized' and 'error' state to false
  bool _initialized = false;
  bool _error = false;

  Future<void> updateAccount(String mCheckoutRequestID) {
    Map<String, String> initData = {
      'CheckoutRequestID': mCheckoutRequestID,
    };
    paymentsRef.set({"info": "$mUserMail receipt data goes here"});

    return paymentsRef
        .collection("deposit")
        .doc(mCheckoutRequestID)
        .set(initData)
        .then((value) => print("Transaction initialized"))
        .catchError((error) => print("failed to init transaction: $error"));
  }

  Stream<DocumentSnapshot> getAccountBalance() {
    if (_initialized) {
      return paymentsRef.collection("balance").doc("account").snapshots();
    } else {
      return null;
    }
  }

  Future<dynamic> startTransaction({double amount, String phone}) async {
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
              host: "us-central1-beauty-56d34.cloudfunctions.net",
              path: "paymentCallback"),
          accountReference: "TamTam",
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
          updateAccount(result["CheckoutRequestID"]);
        }
      }
      print("RESULT: " + transactionInitialisation.toString());
    } catch (e) {
      // You can implement your exception handling here
      //Network unreachabilty is a sure exception
      print('Exception Caught' + e.toString());
    }
  }

  //define an async to initialize and set '_initialized' state to true
  void initializeFlutterfire() async {
    try {
      //wait for firebase to initialize ad set '_initialized' state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });

      paymentsRef =
          FirebaseFirestore.instance.collection('payments').doc(mUserMail);
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
    initializeFlutterfire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mpesa Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Your Account Balance:'),
            StreamBuilder(
                stream: getAccountBalance(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot == null ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      strokeWidth: 1.0,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.active) {
                    if (snapshot.data.data() != null) {
                      Map<String, dynamic> documentFields =
                          snapshot.data.data();

                      return Text(
                          documentFields.containsValue("wallet")
                              ? documentFields["wallet"].toString()
                              : "0",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w800));
                    } else {
                      return Text(
                        '0!',
                      );
                    }
                  } else {
                    return Text("!");
                  }
                })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //show error message if initialiastion failed
          if (_error) {
            print("Error initialising Fb");
            return;
          }

          //show a loader until FlutterFire is initialised
          if (!_initialized) {
            print("Fb Not Initialised");
            return;
          }

          startTransaction(amount: 1.0, phone: "254704122812");
        },
        tooltip: "increment",
        label: Text('Top Up'),
      ),
    );
  }
}
