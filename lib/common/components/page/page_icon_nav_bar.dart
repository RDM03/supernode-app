import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget pageIconNavBar(BuildContext context,
    {Widget title,
    EdgeInsetsGeometry padding,
    Function onTap,
    Widget leading}) {
  return Container(
      padding: padding,
      child: Row(
        children: <Widget>[
          leading ?? Container(),
          Expanded(
            child: title ?? Container(),
          ),
          GestureDetector(
            child: Icon(
              Icons.close,
              color: ColorsTheme.of(context).textPrimaryAndIcons,
            ),
            onTap: onTap,
          ),
        ],
      ));
}
