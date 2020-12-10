import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget link(
  String text, {
  Function onTap,
  AlignmentGeometry alignment: Alignment.centerRight,
  Key key,
}) {
  return Align(
    alignment: alignment,
    child: GestureDetector(
      key: key,
      onTap: onTap,
      child: Container(
        margin: kOuterRowTop5,
        child: GestureDetector(
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
