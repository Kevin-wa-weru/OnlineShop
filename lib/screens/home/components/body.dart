import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'categories.dart';
import 'discount_banner.dart';
import 'home_header.dart';
import 'popular_product.dart';
import 'special_offers.dart';
import 'package:provider/provider.dart';
import '../../../models/Cart.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    Provider.of<PhotoMoto>(context, listen: false).getPricesOfProductsInCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            HomeHeader(),
            SizedBox(height: getProportionateScreenWidth(5)),
            // DiscountBanner(),
            // Categories(),
            // PopularProducts(),
            // SpecialOffers(),
            SizedBox(height: getProportionateScreenWidth(5)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(10)),
            SizedBox(height: getProportionateScreenWidth(5)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(10)),
            SizedBox(height: getProportionateScreenWidth(5)),
            PopularProducts(),
            SizedBox(height: getProportionateScreenWidth(10)),

            // Categories(),
            // PopularProducts(),
            // PopularProducts(),
          ],
        ),
      ),
    );
  }
}
