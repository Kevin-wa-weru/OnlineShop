// import 'package:fl_chart/fl_chart.dart';

// import 'package:flutter/material.dart';

// List<PieChartSectionData> getSections(int touchedIndex) => PieData.data
//     .asMap()
//     .map<int, PieChartSectionData>((index, data) {
//       final isTouched = index == touchedIndex;
//       final double fontSize = isTouched ? 25 : 16;
//       final double radius = isTouched ? 100 : 80;

//       final value = PieChartSectionData(
//         color: data.color,
//         value: data.percent,
//         title: '${data.percent}%',
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: const Color(0xffffffff),
//         ),
//       );

//       return MapEntry(index, value);
//     })
//     .values
//     .toList();

// class PieData {
//   static List<Data> data = [
//     Data(name: 'Shared Orders', percent: 40, color: const Color(0xff0293ee)),
//     // Data(name: 'Orange', percent: 30, color: const Color(0xfff8b250)),
//     // Data(name: 'Black', percent: 15, color: Colors.black),
//     Data(name: 'Fast Orders', percent: 15, color: const Color(0xff13d38e)),
//   ];
// }

// class Data {
//   final String name;

//   final double percent;

//   final Color color;

//   Data({this.name, this.percent, this.color});
// }
