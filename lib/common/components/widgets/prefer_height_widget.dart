import 'package:flutter/material.dart';

class PreferHeightWidget extends PreferredSize implements PreferredSizeWidget {
  final double height;
  final Widget childWidget;
  final Color color;

  PreferHeightWidget({
    Key key,
    @required this.height,
    this.childWidget,
    this.color = Colors.transparent,
  }) : super(
          key: key,
          preferredSize: Size.fromHeight(height),
          child: SizedBox(), // ignore warning
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: height,
      child: childWidget,
    );
  }

  factory PreferHeightWidget.empty() => PreferHeightWidget(height: 0);
}
