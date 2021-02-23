import 'package:flutter/material.dart';
// import 'components/body.dart';
import 'package:shop_app/size_config.dart';
import 'sign.dart';

class Administrator extends StatelessWidget {
  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Administator"),
        ),
        body: Container(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.04),

                    // Text(
                    //   "Sign in with your email and password  \n",
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(height: SizeConfig.screenHeight * 0.008),
                    SignForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.008),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    // NoAccountText(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
