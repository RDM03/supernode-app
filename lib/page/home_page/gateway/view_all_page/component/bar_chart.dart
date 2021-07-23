import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/widgets/bar_graph.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class DDBarChart extends StatefulWidget {
  final bool hasYAxis;
  final int numBar;
  final bool hasTooltip;
  final List<dynamic> tooltipData;
  final List<double> xData;
  final List<String> xLabel;
  final List<int> yLabel;
  final Function(int) notifyGraphBarScroll;

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
  int _indexTappedBar = -1;
  Offset _position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;

    Widget _tooltipShow() {
      if ((_position.dx + (widget.tooltipData[_indexTappedBar].length * 2) + 40) <
          _screenSize.width) {
        return Text('${widget?.tooltipData[_indexTappedBar]}',
            textAlign: TextAlign.center,
            style: FontTheme.of(context).big());
      } else {
        return Text(
            '${widget?.tooltipData[_indexTappedBar]}'
                .replaceFirst(RegExp(r' '), '\n'),
            textAlign: TextAlign.center,
            style: FontTheme.of(context).big());
      }
    }

    return Stack(
      children: [
        Positioned(
          right: 0,
          bottom: -2,
          child: Visibility(
              visible: widget.hasYAxis,
              child: Container(
                  alignment: Alignment.centerRight,
                  height: _screenSize.height - 380,
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
                                  child: Text('$yItem',
                                      textAlign: TextAlign.end,
                                      style: FontTheme.of(context)
                                          .small
                                          .secondary())),
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
        if (_indexTappedBar != -1 &&
          widget.tooltipData.isNotEmpty &&
          _indexTappedBar < widget.tooltipData.length)
            Positioned(
              top: 0,
              left: _position.dx - 20 ?? 0,
              child: Visibility(
                  visible: _indexTappedBar != -1 && widget.hasTooltip,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: ColorsTheme.of(context).boxComponents,
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: [
                          BoxShadow(
                              color: boxShadowColor,
                              offset: Offset(0, 2),
                              blurRadius: 7),
                        ],
                      ),
                      child: _tooltipShow())),
            ),
        Container(
            padding: kOuterRowTop50,
            margin: kRoundRow1005,
            width: _screenSize.width - 50,
            child: Flex(direction: Axis.horizontal, children: [
              Expanded(
                  child: BarGraph(
                      widget.xData, widget.numBar, _screenSize.width - 60,
                      xAxisLabels: widget.xLabel,
                      widgetHeight: _screenSize.height * 0.6,
                      notifyGraphBarScroll: (indexValue) {
                        widget.notifyGraphBarScroll(indexValue);
                        setState(() {
                          _indexTappedBar = -1;
                        });
                      },
                      onTapUp: (indexValue, positionValue) {
                setState(() {
                  _indexTappedBar = indexValue;
                  _position = positionValue;
                });
              })),
            ])),
      ],
    );
  }
}
