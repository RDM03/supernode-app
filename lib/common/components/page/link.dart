import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget link(
  String text, {
  Function onTap,
  AlignmentGeometry alignment: Alignment.centerRight,
  Key key,
  EdgeInsets padding,
}) {
  return GestureDetector(
    key: key,
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Align(
      alignment: alignment,
      child: Container(
        padding: padding ?? EdgeInsets.zero,
        child: Container(
          margin: kOuterRowTop5,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: kMiddleFontOfBlueLink,
          ),
        ),
      ),
    ),
  );
}
