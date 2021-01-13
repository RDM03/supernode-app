import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

class ProfileRow extends StatelessWidget {
  final keyTitle;
  final keySubtitle;
  final String name;
  final String position;
  final EdgeInsetsGeometry contentPadding;
  final Widget trailing;
  final Function onTap;

  const ProfileRow({
    Key key,
    this.keyTitle,
    this.keySubtitle,
    this.name = '',
    this.position = '',
    this.contentPadding,
    this.trailing,
    this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
}
