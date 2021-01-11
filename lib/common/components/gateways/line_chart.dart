import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class SNLineChart extends StatelessWidget {
  const SNLineChart(
      {Key key,
      @required this.axisX,
      @required this.axisY,
      @required this.data,
      this.maxY = 1,
      this.maxX = 1})
      : super(key: key);

  final double maxY;
  final double maxX;
  final List axisX;
  final List axisY;
  final List<List> data;

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        minX: 0,
        minY: 0,
        maxX: maxX,
        maxY: maxY,
        lineTouchData: LineTouchData(
          enabled: false,
        ),
        gridData: FlGridData(
          show: false,
        ),
        titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              // reservedSize: 22,
              textStyle: const TextStyle(
                color: hintFont,
                fontSize: 12,
              ),
              // margin: 10,
              getTitles: (value) =>
                  axisX.length > value.toInt() + 1 ? axisX[value.toInt()] : '',
            ),
            leftTitles: SideTitles(
              showTitles: true,
              textStyle: const TextStyle(
                color: hintFont,
                fontSize: 12,
              ),
              // margin: 30
              // interval: 6,
              // reservedr  Size: 300,
              // getTitles: (value) {

              //   if(value == axisY[0]){
              //     return value.toInt().toString();
              //   }else if(value == axisY[1]){
              //     return value.toInt().toString();
              //   }else if(value == axisY[2]){
              //     return value.toInt().toString();
              //   }else if(value == axisY[3]){
              //     return value.toInt().toString();
              //   }else if(value == axisY[4]){
              //     return value.toInt().toString();
              //   }else if(value == axisY[5]){
              //     return value.toInt().toString();
              //   }else{
              //     return '';
              //   }
              // }
            )),
        borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(
                color: hintFont,
                width: 1,
              ),
            )),
        lineBarsData: [
          LineChartBarData(
            spots: data
                ?.map((item) => FlSpot(item[0].toDouble(), item[1].toDouble()))
                .toList(),
            isCurved: true,
            curveSmoothness: 0,
            colors: const [
              Colors.green,
            ],
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(show: true),
            belowBarData: BarAreaData(
              show: false,
            ),
          ),
        ]));
  }
}
