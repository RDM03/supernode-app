import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/spacing.dart';

Widget rowRight(String text,{TextStyle style}){
  return Container(
    margin: kRoundRow202,
    alignment: Alignment.centerRight,
    child: Text(
      text,
      style: style
    )
  );
}