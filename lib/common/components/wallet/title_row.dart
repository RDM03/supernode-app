import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget titleRow(String name) {
  return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Container(
          // padding: kOuterRowTop,
          child: Text(
        name,
        textAlign: TextAlign.left,
        style: kBigFontOfBlack,
      )));
}
