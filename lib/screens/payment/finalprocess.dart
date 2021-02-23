import 'package:flutter/material.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';

class FinalScreen extends StatefulWidget {
  final String text;
  final String text2;
  final String text3;
  FinalScreen({Key key, @required this.text, this.text2, this.text3})
      : super(key: key);
  static String routeName = "/details";

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
      'sendmessage',
      options: HttpsCallableOptions(timeout: Duration(seconds: 5)));
  // ignore: non_constant_identifier_names
  _NotifyUser() async {
    try {
      final HttpsCallableResult result = await callable.call(
        <String, dynamic>{'DeviceToken': widget.text},
      );
      print(result.data['response']);
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

  @override
  void initState() {
    _NotifyUser();
    print('message was sent to this device token: ${widget.text}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                  child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: 130,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/check3.gif'),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'Payment Received',
                      style: new TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'Collect Your Item(s) at ${widget.text2} ',
                      style: new TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'on ${widget.text3} ',
                      style: new TextStyle(color: Colors.black54),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(
                      'between 8.00am to 5.00pm ',
                      style: new TextStyle(color: Colors.black54),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        'Back to HomePage',
                        style: new TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white12,
    elevation: 0,
  );
}
