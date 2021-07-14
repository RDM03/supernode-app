import 'dart:math';

import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class CircularGraph extends StatelessWidget {
  static const Widget defaultWidget = SizedBox();

  /// Value [0-100]
  final double percentage;

  /// Color of CircularGraph
  final Color graphColor;

  /// Widget displayed at center of CircularGraph
  final Widget child;
  final Color shadowColor = backgroundColor;
  final double size;
  final double paddingSize;
  final double lineWidth;

  CircularGraph(this.percentage, this.graphColor, {this.child = defaultWidget, this.size = 200, this.paddingSize = 17.0, this.lineWidth = 20.0});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
              colors: [Colors.white, shadowColor], stops: [0.97, 1.0]),
        ),
        child: Container(
          width: size - paddingSize,
          height: size - paddingSize,
          alignment: Alignment.center,
          child: Container(
              height: size - paddingSize - lineWidth,
              width: size - paddingSize - lineWidth,
              child: new CustomPaint(
                  foregroundPainter: new MyPainter(
                      lineColor: graphColor.withOpacity(0.1),
                      completeColor: graphColor,
                      completePercent: percentage,
                      width: lineWidth),
                  child: Container(
                      width: size - paddingSize - 2 * lineWidth,
                      height: size - paddingSize - 2 * lineWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        width: size - 2 * paddingSize - 2 * lineWidth,
                        height: size - 2 * paddingSize - 2 * lineWidth,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7,
                              color: shadowColor,
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: child,
                        ),
                      )))),
        ));
  }
}

/// https://medium.com/@rjstech/flutter-custom-paint-tutorial-build-a-radial-progress-6f80483494df
class MyPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  MyPainter(
      {this.lineColor, this.completeColor, this.completePercent, this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
