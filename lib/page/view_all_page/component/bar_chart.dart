import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/widgets/bar_graph.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

class DDBarChart extends StatelessWidget {
  final bool hasYAxis;
  final int numBar;
  final List<double> xData;
  final List<String> xLabel;
  final List<double> yLabel;
  final Function(int, {ScrollController scrollController}) notifyGraphBarScroll;

  const DDBarChart(
      {Key key,
      @required this.xData,
      @required this.xLabel,
      this.hasYAxis = false,
      this.numBar = 7,
      this.yLabel,
      this.notifyGraphBarScroll})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: kRoundRow2005,
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
              child: BarGraph(xData, numBar, MediaQuery.of(context).size.width,
                  xAxisLabels: xLabel,
                  widgetHeight: MediaQuery.of(context).size.height * 0.6,
                  notifyGraphBarScroll: notifyGraphBarScroll)),
          Visibility(
              visible: hasYAxis,
              child: Container(
                  child: Flex(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      direction: Axis.vertical,
                      children: yLabel.map((yItem) {
                        return Expanded(
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.topCenter,
                              child: Text(
                                '$yItem',
                                textAlign: TextAlign.start,
                                style: kSmallFontOfGrey,
                              )),
                        );
                      }).toList())))
        ]));
  }
}
