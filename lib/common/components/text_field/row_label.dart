import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget rowLabel(String text,{Widget suffixChild}){
  return Container(
    margin: kOuterRowTop20,
    child: Row(
      children: <Widget>[
        Text(
          text,
          style: kMiddleFontOfBlack,
        ),
        Spacer(),
        Visibility(
          visible: suffixChild != null,
          child: suffixChild ?? Container(),
        )
      ]
    )
  );
}