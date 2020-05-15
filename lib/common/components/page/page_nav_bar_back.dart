import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageNavBarBack(String name,{EdgeInsetsGeometry padding,Function onTap}){
  return Container(
    padding: padding,
    child: Row(
      children: <Widget>[
        GestureDetector(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: 36,
          ),
          onTap: onTap,
        ),
        Spacer(),
        Text(
          name,
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        ),
        Spacer(),
        Spacer(),
      ],
    )
  );
}