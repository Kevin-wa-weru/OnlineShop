import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/checkout/checkoutscreen.dart';
import '../../../Services/firebaseservices.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:shop_app/components/default_button.dart';
import '../../../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  User _user = FirebaseAuth.instance.currentUser;
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

  FirebaseServices _firebaseServices = FirebaseServices();
  @override
  initState() {
    super.initState();
    getPricesOfProductsInCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices.usersRef
                  .doc(_firebaseServices.getUserId())
                  .collection("Cart")
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error: ${snapshot.error}"),
                    ),
                  );
                }
                // Collection Data ready to display
                if (snapshot.connectionState == ConnectionState.done) {
                  // Display the data inside a list view
                  return ListView(
                    padding: EdgeInsets.only(
                      top: 0.0,
                      bottom: 12.0,
                    ),
                    children: snapshot.data.docs.map((document) {
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => Body(
                          //         productId: document.id,
                          //       ),
                          //     ));
                        },
                        child: FutureBuilder(
                          future: _firebaseServices.productsRef
                              .doc(document.id)
                              .get(),
                          builder: (context, productSnap) {
                            if (productSnap.hasError) {
                              return Container(
                                child: Center(
                                  child: Text("${productSnap.error}"),
                                ),
                              );
                            }
                            if (productSnap.connectionState ==
                                ConnectionState.done) {
                              Map _productMap = productSnap.data.data();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 2.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 88,
                                      child: AspectRatio(
                                        aspectRatio: 0.88,
                                        child: Container(
                                          padding: EdgeInsets.all(
                                              getProportionateScreenWidth(10)),
                                          decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Image.network(
                                            "${_productMap['images'][0]}",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${_productMap['name']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                          maxLines: 2,
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text.rich(
                                              TextSpan(
                                                text:
                                                    "\ksh ${_productMap['price']}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: kPrimaryColor),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          "   size:${document.data()['size']}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1),
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                final CollectionReference
                                                    _sharedordersRef =
                                                    FirebaseFirestore.instance
                                                        .collection("Users");
                                                _sharedordersRef
                                                    .doc(_user.uid)
                                                    .collection('Cart')
                                                    .doc(document.id)
                                                    .delete();
                                                setState(() {});
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Container(
                                                  child: Text('Remove'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                              //
                            }

                            return Container(
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
                // Loading State
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(15),
            horizontal: getProportionateScreenWidth(30),
          ),
          // height: 174,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, -15),
                blurRadius: 20,
                color: Color(0xFFDADADA).withOpacity(0.15),
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [],
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Total:\n",
                      children: [
                        TextSpan(
                          text: totalCartValue.toString(),
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: getProportionateScreenWidth(190),
                    child: DefaultButton(
                      text: "Check Out",
                      press: () {
                        Navigator.pushNamed(context, CheckoutScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
