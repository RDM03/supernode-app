import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class BarGraph extends StatelessWidget {
  /// List of values [0-1]
  final List<double> graphValues;
  /// Number of graph bars visible. The rest of values are scrolled horizontally
  final int barsOnScreen;
  /// Color of BarGraph
  final Color graphColor;
  /// Ẃidth of the widget
  final double widgetWidth;
  /// Height of the widget
  final double widgetHeight;
  /// notifyGraphBarScroll
  final Function(int) notifyGraphBarScroll;
  final double barWidth = 20.0;
  final ScrollController scrollCtrl = ScrollController();
  double spaceBetweenLines;
  double scrollableWidth;
  int currentBar = 0;

  BarGraph(this.graphValues, this.barsOnScreen, this.widgetWidth, {this.widgetHeight= 200, this.graphColor = minerColor, this.notifyGraphBarScroll}) {
    spaceBetweenLines = (widgetWidth - (barsOnScreen * barWidth)) / (barsOnScreen - 1);
    scrollableWidth = barWidth * graphValues.length + spaceBetweenLines * (graphValues.length - 1);
    if (notifyGraphBarScroll != null) {
      scrollCtrl.addListener(() {
        double position = scrollCtrl.offset / (spaceBetweenLines + barWidth);
        if (position.round() > currentBar) {
          currentBar++;
          notifyGraphBarScroll(currentBar);
        }
        if (position.round() < currentBar) {
          currentBar--;
          notifyGraphBarScroll(currentBar);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      controller: scrollCtrl,
      reverse: true,
      child: CustomPaint(
          painter: GraphPainter(
              lineColor: graphColor,
              completePercents: graphValues,
              visibleWidth: widgetWidth,
              linesOnScreen: barsOnScreen,
              spaceBetweenLines: spaceBetweenLines,
              lineWidth: barWidth
          ),
          child: Container(
            width: scrollableWidth,
            height: widgetHeight,
            child: SizedBox(),
          )
      ),
    );
  }
}

class GraphPainter extends CustomPainter{
  final Color lineColor;
  final List<double> completePercents;
  final double visibleWidth;
  final int linesOnScreen;
  final double spaceBetweenLines;
  final double lineWidth;
  GraphPainter({this.lineColor, this.completePercents, this.visibleWidth, this.linesOnScreen, this.spaceBetweenLines, this.lineWidth});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;
    Paint lineBkgrd = new Paint()
      ..color = lineColor.withOpacity(.2)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    double x;
    for (int i = 0; i < completePercents.length; i++) {
      x = lineWidth / 2 + i * (lineWidth + spaceBetweenLines);
      canvas.drawLine(new Offset(x, size.height - lineWidth / 2), new Offset(x,  lineWidth / 2), lineBkgrd);
      canvas.drawLine(new Offset(x, size.height - lineWidth / 2),
          new Offset(x, (size.height - lineWidth) * (1 - completePercents[completePercents.length - 1 - i]) + lineWidth / 2), line);
    }
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}