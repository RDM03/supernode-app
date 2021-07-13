import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget homeBar(BuildContext context, String titleText,
    {Function onPressed, Widget action, Widget title}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: ColorsTheme.of(context).primaryBackground,
    elevation: 0,
    title: title ??
        Text(
          titleText,
          style: FontTheme.of(context).big.primary.bold(),
        ),
    actions: [
      action != null
          ? action
          : IconButton(
              icon: Icon(
                Icons.settings,
                color: ColorsTheme.of(context).textPrimaryAndIcons,
              ),
              onPressed: onPressed,
            ),
    ],
  );
}
