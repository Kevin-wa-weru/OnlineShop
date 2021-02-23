import 'package:flutter/material.dart';
import 'custominput.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Services/firebaseservices.dart';
import 'updater.dart';

class UpdateOrder extends StatefulWidget {
  @override
  _UpdateOrderState createState() => _UpdateOrderState();
}

class _UpdateOrderState extends State<UpdateOrder> {
  var email;
  bool isLoading;
  bool resulting = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("UpdateOrder"),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 25,
            ),
            CustomInput(
              hintText: "Customer email..",
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              onSubmitted: (value) {
                email = value;
                // _passwordFocusNode.requestFocus();
              },
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 68.0, right: 68.0),
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: isLoading == true ? Colors.white : Colors.deepOrange,
                onPressed: () async {
                  // setState(() {
                  //   isLoading = true;
                  // });
                  // _updateOrder();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Updater(text: email.trim()),
                      ));
                },
                child: Flexible(
                  child: new Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20.0,
                    ),
                    child: isLoading == true
                        ? CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Colors.orange),
                          )
                        : Text(
                            "Search Orders",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ));
  }
}
