import 'package:coronavirus_covid19_tracker/app/utils/app_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DataChart extends StatelessWidget {
  final double confirmed;
  final double recovered;
  final double deaths;

  const DataChart({Key key, this.confirmed, this.recovered, this.deaths})
      : super(key: key);

  List<PieChartSectionData> showingSections() {
    int lengthOfSections = 3;
    return List.generate(lengthOfSections, (i) {
      final double fontSize = 16;
      final double radius = 15;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: color_for_confirmed,
            value: confirmed,
            radius: radius,
            title: '',
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: color_for_recovered,
            value: recovered,
            radius: radius,
            title: '',
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: color_for_deaths,
            value: deaths,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      child: PieChart(
        PieChartData(
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 50,
            sections: showingSections()),
        swapAnimationDuration: Duration(milliseconds: 750),
      ),
    );
  }
}
