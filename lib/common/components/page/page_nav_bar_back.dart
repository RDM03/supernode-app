import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

@deprecated
Widget pageNavBarBack(BuildContext context, String name,
    {EdgeInsetsGeometry padding, Function onTap}) {
  return Container(
      padding: padding,
      child: Row(
        children: <Widget>[
          GestureDetector(
            child: Icon(
              Icons.chevron_left,
              color: ColorsTheme.of(context).textPrimaryAndIcons,
              size: 36,
            ),
            onTap: onTap,
          ),
          Spacer(),
          Text(
            name,
            textAlign: TextAlign.left,
            style: FontTheme.of(context).big(),
          ),
          Spacer(),
          Spacer(),
        ],
      ));
}
