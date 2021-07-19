import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget listItem(
  String title, {
  EdgeInsetsGeometry contentPadding,
  Widget trailing,
  Function onTap,
  Widget leading,
  Key key,
}) {
  return Builder(
    builder: (context) => ListTile(
      key: key,
      leading: leading,
      contentPadding: contentPadding,
      title: Text(title, style: FontTheme.of(context).big()),
      trailing: trailing != null ? trailing : Icon(Icons.chevron_right),
      onTap: onTap,
    ),
  );
}
