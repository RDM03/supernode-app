import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget profile({keyTitle, keySubtitle, String name = '',String position = '',EdgeInsetsGeometry contentPadding,Widget trailing,Function onTap}){
  return ListTile(
    contentPadding: contentPadding,
    leading: Icon(
      Icons.account_circle,
      size: 44,
    ),
    title: Text(
      name,
      key: keyTitle,
      style: kBigFontOfBlack,
    ),
    subtitle: Text(
      position,
      key: keySubtitle,
      style: kMiddleFontOfGrey,
    ),
    trailing: trailing,
    onTap: onTap,
  );
}