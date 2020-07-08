import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';

Widget homeBar(String title, {Function onPressed, Widget action}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    title: Text(
      title,
      textAlign: TextAlign.left,
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
