import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

@deprecated
Widget paragraph(String text) {
  return Builder(
    builder: (context) => Container(
      margin: EdgeInsets.only(top: 14),
      child: Text(
        text,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: ColorsTheme.of(context).textPrimaryAndIcons,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.5,
        ),
      ),
    ),
  );
}
