import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class SNBarChart extends StatelessWidget {
  const SNBarChart(
      {Key key,
      @required this.xAxis,
      @required this.yAxis,
      @required this.data,
      this.leftGroupTitle,
      this.rightGroupTitle})
      : super(key: key);

  final List<String> xAxis;
  final List<String> yAxis;
  final Map leftGroupTitle;
  final Map rightGroupTitle;
  final List<List<double>> data;

  @override
  Widget build(Object context) {
    return Column(
      children: <Widget>[_barTitle(), _bar()],
    );
  }

  Widget _barTitle() {
    return Row(children: <Widget>[
      _title(leftGroupTitle['name'] ?? 'Left',
          leftGroupTitle['color'] ?? Colors.green),
      _title(rightGroupTitle['name'] ?? 'Right',
          rightGroupTitle['color'] ?? Colors.blue),
    ]);
  }

  Widget _title(String name, Color color) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15,
          height: 15,
          child: Container(color: color),
        ),
        Container(
          padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 5),
          child: Text(
            name,
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget _bar() {
    return BarChart(
      BarChartData(
          // axisTitleData: FlAxisTitleData(
          //   show: true,
          //   topTitle: AxisTitle(
          //     titleText: 'rrrrrrrrrrr'
          //   )
          // ),
          // maxY: 20,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey,
              getTooltipItem: (_a, _b, _c, _d) => null,
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(color: Colors.grey, fontSize: 12),
              getTitles: (value) =>
                  xAxis.length > value.toInt() + 1 ? xAxis[value.toInt()] : '',
            ),
            leftTitles: SideTitles(
              showTitles: true,
              textStyle: TextStyle(color: Colors.grey, fontSize: 12),
              getTitles: (value) =>
                  yAxis.length > value.toInt() + 1 ? yAxis[value.toInt()] : '',
            ),
          ),
          borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(
                  color: hintFont,
                  width: 1,
                ),
              )),
          barGroups: data
              ?.map((item) => makeGroupData(item[0].toInt(), item[1], item[2]))
              .toList()),
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(barsSpace: 4, x: x, barRods: [
      BarChartRodData(
        y: y1,
        color: Colors.green,
      ),
      BarChartRodData(
        y: y2,
      ),
    ]);
  }
}
