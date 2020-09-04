import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget listItem(
  String title, {
  EdgeInsetsGeometry contentPadding,
  Widget trailing,
  Function onTap,
  Key key,
}) {
  return ListTile(
    key: key,
    contentPadding: contentPadding,
    title: Text(title, style: kBigFontOfBlack),
    trailing: trailing != null ? trailing : Icon(Icons.chevron_right),
    onTap: onTap,
  );
}
