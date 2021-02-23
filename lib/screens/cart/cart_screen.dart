import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart/components/body.dart';

// import '../../Services/firebaseservices.dart';
class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
