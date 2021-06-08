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
  /// firstIndex: The first bar means that there is the first item in the most left of the visibility.
  final Function(int, {ScrollController scrollController, int firstIndex}) notifyGraphBarScroll;
  final double barWidth = 20.0;
  final ScrollController scrollCtrl = ScrollController();
  double spaceBetweenLines;
  double scrollableWidth;
  int currentBar = 0;
  List<double> xList = [];

  //onTapUp event of each bar
  final Function(int index, Offset position) onTapUp;

  BarGraph(this.graphValues, this.barsOnScreen, this.widgetWidth,
      {this.xAxisLabels,
      this.widgetHeight = 200,
      this.graphColor = minerColor,
      this.notifyGraphBarScroll,
      this.onTapUp}) {
    spaceBetweenLines =
        (widgetWidth - (barsOnScreen * barWidth)) / (barsOnScreen - 1);
    scrollableWidth = barWidth * graphValues.length +
        spaceBetweenLines * (graphValues.length - 1);
    if (notifyGraphBarScroll != null) {
      scrollCtrl.addListener(() {
        double position = scrollCtrl.offset / (spaceBetweenLines + barWidth);
        int firstIndex = 0;
        
        if(scrollCtrl.offset <= barWidth){
          firstIndex = 0;
        } else {
          firstIndex = ((scrollCtrl.offset) / (spaceBetweenLines + barWidth * 2)).ceil();
        }

        print(scrollCtrl.offset);
        print(firstIndex);

        if (position.round() > currentBar) {
          currentBar++;
          notifyGraphBarScroll(currentBar, scrollController: scrollCtrl, firstIndex: firstIndex);
        }
        if (position.round() < currentBar) {
          currentBar--;
          notifyGraphBarScroll(currentBar, scrollController: scrollCtrl, firstIndex: firstIndex);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: scrollCtrl,
        physics: AlwaysScrollableScrollPhysics(),
        reverse: true,
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            _onTap(context, detail);
          },
          child: CustomPaint(
              painter: GraphPainter(
                  lineColor: graphColor,
                  completePercents: graphValues,
                  labels: xAxisLabels,
                  visibleWidth: widgetWidth,
                  linesOnScreen: barsOnScreen,
                  spaceBetweenLines: spaceBetweenLines,
                  lineWidth: barWidth,
                  xListCallback: (index, xValue) {
                    if (index == 0) {
                      xList = [];
                    }

                    xList.add(xValue);
                  }),
              child: Container(
                width: scrollableWidth,
                height: widgetHeight,
                child: SizedBox(),
              )),
        ));
  }

  void _onTap(BuildContext context, TapUpDetails detail) {
    if (onTapUp == null) return;

    int index = -1;
    Offset localOffset = detail.localPosition;

    for (int i = 0; i < xList.length; i++) {
      if (localOffset.dx >= xList[i] - barWidth && localOffset.dx <= xList[i]) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      onTapUp(xList.length - 1 - index, detail.globalPosition);
    }
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
  final Function(int, double) xListCallback;
  GraphPainter(
      {this.lineColor,
      this.completePercents,
      this.labels,
      this.visibleWidth,
      this.linesOnScreen,
      this.spaceBetweenLines,
      this.lineWidth,
      this.xListCallback});
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
      xListCallback(i, x + lineWidth / 2);
      canvas.drawLine(new Offset(x, size.height - lineWidth / 2 - labelHeight),
          new Offset(x, lineWidth / 2), lineBkgrd);
      if (completePercents[completePercents.length - 1 - i] > 0)
        canvas.drawLine(
            new Offset(x, size.height - lineWidth / 2 - labelHeight),
            new Offset(
                x,
                (size.height - lineWidth - labelHeight) *
                        (1 -
                            completePercents[completePercents.length - 1 - i]) +
                    lineWidth / 2),
            line);
      if (labels != null) {
        final textSpan = TextSpan(
          text: labels[labels.length - 1 - i],
          style: kSmallFontOfGrey,
        );
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: 1,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(
          minWidth: 0,
          // maxWidth: spaceBetweenLines,
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
