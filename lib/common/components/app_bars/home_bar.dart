import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget homeBar(String titleText,
    {Function onPressed, Widget action, Widget title}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: backgroundColor,
    elevation: 0,
    title: title ??
        Text(
          titleText,
          style: kBigFontOfBlack,
        ),
    actions: [
      action != null
          ? action
          : IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              onPressed: onPressed,
            ),
    ],
  );
}
