import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget panelFrame(
    {key,
    double height,
    Widget child,
    EdgeInsetsGeometry rowTop,
    Color customPanelColor}) {
  return Container(
      key: key,
      height: height,
      margin: rowTop != null ? rowTop : kOuterRowTop20,
      decoration: BoxDecoration(
        color: customPanelColor == null ? panelColor : customPanelColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: shodowColor,
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      child: child);
}
