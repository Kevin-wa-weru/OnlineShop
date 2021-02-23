import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
// import 'indicators_widget.dart';
// import 'pie_chart_sections.dart';

class Revenue extends StatefulWidget {
  final fpercent;
  final spercent;
  final apprevenue;
  final stotal;
  final ftotal;

  const Revenue(
      {Key key,
      this.fpercent,
      this.spercent,
      this.apprevenue,
      this.stotal,
      this.ftotal})
      : super(key: key);
  @override
  _RevenueState createState() => _RevenueState();
}

class _RevenueState extends State<Revenue> {
  int touchedIndex;
  // var totalfastpay = 0;
  // var totalsharedpay = 0;
  // var apprevenue = 0;
  var fastpercent;
  var sharedpercent;
  bool chartloader = false;
  bool loader = false;
  // getAnalysis() async {
  //   // setState(() {
  //   //   loader = true;
  //   //   // chartloader = true;
  //   // });

  //   FirebaseFirestore.instance
  //       .collection('sharedorders')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) => {
  //             querySnapshot.docs.forEach((doc) {
  //               print(doc["TotalPaid"]);
  //               var ty = doc["TotalPaid"];
  //               setState(() {
  //                 totalfastpay = totalfastpay + ty;
  //                 apprevenue = totalfastpay + totalsharedpay;
  //                 getpercent();
  //                 // fastpercent = totalfastpay / apprevenue * 100;
  //                 // sharedpercent = totalsharedpay / apprevenue * 100;
  //               });

  //               // var _lister = doc["TotalPaid"].toList();
  //               // print(_lister.toString());
  //               // // var _list = puffy.values.toList();
  //               // fast.add(value)
  //             })
  //           });
  //   FirebaseFirestore.instance
  //       .collection('fastorders')
  //       .get()
  //       .then((QuerySnapshot querySnapshot) => {
  //             querySnapshot.docs.forEach((doc) {
  //               print(doc["TotalPaid"]);
  //               var dy = doc["TotalPaid"];
  //               setState(() {
  //                 totalsharedpay = totalsharedpay + dy;
  //                 apprevenue = totalfastpay + totalsharedpay;
  //                 getpercent();
  //               });
  //             })
  //           });
  //   setState(() {
  //     // getpercent();
  //     PieData.data.add(
  //       Data(name: 'Shared Orders', percent: sharedpercent, color: Colors.red),
  //     );
  //     PieData.data.add(
  //       Data(name: 'Fast Orders', percent: 25, color: const Color(0xff13d38e)),
  //     );
  //     loader = false;
  //     chartloader = false;
  //   });
  // }

  // Future getpercent() {
  //   setState(() {
  //     fastpercent = totalfastpay / apprevenue * 100;
  //     sharedpercent = totalsharedpay / apprevenue * 100;
  //     print('FPercent' + fastpercent.toString());
  //   });

  //   setState(() {});
  // }

  @override
  void initState() {
    PieData.data.clear();
    setState(() {
      loader = true;
      PieData.data.add(
        Data(
            name: 'Shared Orders',
            percent: double.parse(widget.spercent),
            color: Colors.blue),
      );
      PieData.data.add(
        Data(
            name: 'Fast Orders',
            percent: double.parse(widget.fpercent),
            color: Colors.green),
      );
    });

    // getAnalysis();
    // getpercent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 28.0),
            child: Center(
              child: Card(
                elevation: 0,
                child: Text('Total Monthly Revenue: Ksh ' +
                    widget.apprevenue.toString()),
              ),
            ),
          ),
          Container(
            child: DataTable(
              columns: [
                // DataColumn(label: Text('Depots')),
                DataColumn(label: Text('Fast')),
                DataColumn(label: Text('Shared')),
                DataColumn(label: Text('Total')),
              ],
              rows: [
                DataRow(cells: [
                  // DataCell(Text('A')),
                  DataCell(Text('ksh ' + widget.stotal.toString() + '.00')),
                  DataCell(Text('Ksh ' + widget.ftotal.toString() + '.00')),
                  DataCell(Text('Ksh ' + widget.apprevenue.toString() + '.00')),
                ]),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 88.0),
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (pieTouchResponse) {
                      setState(() {
                        if (pieTouchResponse.touchInput is FlLongPressEnd ||
                            pieTouchResponse.touchInput is FlPanEnd) {
                          touchedIndex = -1;
                        } else {
                          touchedIndex = pieTouchResponse.touchedSectionIndex;
                        }
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: getSections(touchedIndex),
                ),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: IndicatorsWidget(),
              ),
            ],
          )
        ],
      )),
    );
  }
}

class PieData {
  static List<Data> data = [
    // Data(name: 'Shared Orders', percent: 40, color: const Color(0xff0293ee)),
    // Data(name: 'Orange', percent: 30, color: const Color(0xfff8b250)),
    // Data(name: 'Black', percent: 15, color: Colors.black),
    // Data(name: 'Fast Orders', percent: 15, color: const Color(0xff13d38e)),
  ];
}

class Data {
  final String name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}

List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final isTouched = index == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 100 : 80;

      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: '${data.percent}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();

class IndicatorsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: PieData.data
            .map(
              (data) => Container(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: buildIndicator(
                    color: data.color,
                    text: data.name,
                    // isSquare: true,
                  )),
            )
            .toList(),
      );

  Widget buildIndicator({
    @required Color color,
    @required String text,
    bool isSquare = false,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}
