import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

class BarGraph extends StatelessWidget {
  /// List of values [0-1]
  final List<double> graphValues;

  /// List labels
  final List<String> xAxisLabels;

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

  BarGraph(this.graphValues, this.barsOnScreen, this.widgetWidth,
      {this.xAxisLabels,
      this.widgetHeight = 200,
      this.graphColor = minerColor,
      this.notifyGraphBarScroll}) {
    spaceBetweenLines =
        (widgetWidth - (barsOnScreen * barWidth)) / (barsOnScreen - 1);
    scrollableWidth = barWidth * graphValues.length +
        spaceBetweenLines * (graphValues.length - 1);
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
              labels: xAxisLabels,
              visibleWidth: widgetWidth,
              linesOnScreen: barsOnScreen,
              spaceBetweenLines: spaceBetweenLines,
              lineWidth: barWidth),
          child: Container(
            width: scrollableWidth,
            height: widgetHeight,
            child: SizedBox(),
          )),
    );
  }
}

class GraphPainter extends CustomPainter {
  final Color lineColor;
  final List<double> completePercents;
  final List<String> labels;
  final double visibleWidth;
  final int linesOnScreen;
  final double spaceBetweenLines;
  final double lineWidth;
  GraphPainter(
      {this.lineColor,
      this.completePercents,
      this.labels,
      this.visibleWidth,
      this.linesOnScreen,
      this.spaceBetweenLines,
      this.lineWidth});
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
    double labelHeight = 0;
    if (labels != null) labelHeight = 20;
    for (int i = 0; i < completePercents.length; i++) {
      x = lineWidth / 2 + i * (lineWidth + spaceBetweenLines);
      canvas.drawLine(new Offset(x, size.height - lineWidth / 2 - labelHeight),
          new Offset(x, lineWidth / 2), lineBkgrd);
      canvas.drawLine(
          new Offset(x, size.height - lineWidth / 2 - labelHeight),
          new Offset(
              x,
              (size.height - lineWidth - labelHeight) *
                      (1 - completePercents[completePercents.length - 1 - i]) +
                  lineWidth / 2),
          line);
      if (labels != null) {
        final textSpan = TextSpan(
          text: labels[labels.length - 1 - i],
          style: kSmallFontOfBlack,
        );
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          maxWidth: spaceBetweenLines,
        );
        double xTextStart = x - textPainter.width / 2;
        if (labels.length - 1 - i == 0)
          xTextStart = x - textPainter.width + lineWidth / 2;
        if (i == 0) xTextStart = x - lineWidth / 2;
        final offset = Offset(xTextStart, size.height - textPainter.height);
        textPainter.paint(canvas, offset);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
