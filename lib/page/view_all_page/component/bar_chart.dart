import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/widgets/bar_graph.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDBarChart extends StatefulWidget {
  final bool hasYAxis;
  final int numBar;
  final bool hasTooltip;
  final List<dynamic> tooltipData;
  final List<double> xData;
  final List<String> xLabel;
  final List<int> yLabel;
  final Function(int, {ScrollController scrollController, int firstIndex})
      notifyGraphBarScroll;

  const DDBarChart(
      {Key key,
      @required this.xData,
      @required this.xLabel,
      this.hasYAxis = false,
      this.hasTooltip = false,
      this.tooltipData,
      this.numBar = 7,
      this.yLabel,
      this.notifyGraphBarScroll})
      : super(key: key);

  @override
  _DDBarChartState createState() => _DDBarChartState();
}

class _DDBarChartState extends State<DDBarChart> {
  int index = -1;
  Offset position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: -2,
          child: Visibility(
              visible: widget.hasYAxis,
              child: Container(
                  alignment: Alignment.centerRight,
                  height: MediaQuery.of(context).size.height - 380,
                  width: 50,
                  padding: EdgeInsets.only(bottom: 50),
                  child: Stack(
                    children: [
                      Flex(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          direction: Axis.vertical,
                          children: widget.yLabel.map((yItem) {
                            return Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    '$yItem',
                                    textAlign: TextAlign.end,
                                    style:
                                        FontTheme.of(context).small.secondary(),
                                  )),
                            );
                          }).toList()),
                    ],
                  ))),
        ),
        Positioned(
            right: 0,
            bottom: 25,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                alignment: Alignment.topCenter,
                child: Text(
                  '0',
                  textAlign: TextAlign.end,
                  style: FontTheme.of(context).small.secondary(),
                ))),
        Positioned(
          top: 0,
          left: position.dx - 20 ?? 0,
          child: Visibility(
              visible: index != -1 && widget.hasTooltip,
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  boxShadow: [
                    BoxShadow(
                      color: shodowColor,
                      offset: Offset(0, 2),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Text(
                  index != -1 &&
                          widget.tooltipData.isNotEmpty &&
                          index < widget.tooltipData.length
                      ? '${widget?.tooltipData[index] ?? 0}'
                      : '0',
                  style: FontTheme.of(context).big(),
                ),
              )),
        ),
        Container(
            padding: kOuterRowTop50,
            margin: kRoundRow1005,
            width: MediaQuery.of(context).size.width - 50,
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                  child: BarGraph(widget.xData, widget.numBar,
                      MediaQuery.of(context).size.width - 60,
                      xAxisLabels: widget.xLabel,
                      widgetHeight: MediaQuery.of(context).size.height * 0.6,
                      notifyGraphBarScroll: (indexValue,
                          {ScrollController scrollController, int firstIndex}) {
                widget.notifyGraphBarScroll(indexValue,
                    scrollController: scrollController, firstIndex: firstIndex);
                setState(() {
                  index = -1;
                });
              }, onTapUp: (indexValue, positionValue) {
                setState(() {
                  index = indexValue;
                  position = positionValue;
                });
              })),
            ])),
      ],
    );
  }
}
