import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageNavBar(
  String name, {
  EdgeInsetsGeometry padding,
  Function onTap,
  Widget actionWidget,
  Widget leadingWidget,
}) {
  return Container(
    padding: padding,
    child: Row(
      children: <Widget>[
        if (leadingWidget != null) ...[
          leadingWidget,
          Spacer(),
        ],
        Text(
          name,
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        ),
        Spacer(),
        GestureDetector(
          key: ValueKey('navActionButton'),
          child: actionWidget == null
              ? Icon(
                  Icons.close,
                  color: Colors.black,
                )
              : actionWidget,
          onTap: onTap,
        ),
      ],
    ),
  );
}
