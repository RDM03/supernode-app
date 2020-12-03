import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget introduction(String text, {double left = 0,double right = 14,double top = 30,double bottom = 0, Key key} ){
  return Container(
    // height: 66,
    margin: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
    child: Text(
      text,
      key: key,
      textAlign: TextAlign.left,
      style: kMiddleFontOfGrey,
    )
  );
}