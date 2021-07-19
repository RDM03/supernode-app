import 'package:flutter/material.dart';
import 'package:supernodeapp/common/components/loading_flash.dart';
import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class ProfileRow extends StatelessWidget {
  final keyTitle;
  final keySubtitle;
  final String name;
  final String position;
  final EdgeInsetsGeometry contentPadding;
  final Widget trailing;
  final bool loading;
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
    this.loading = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: contentPadding,
      leading: Icon(
        Icons.account_circle,
        size: 44,
      ),
      title: loading
          ? loadingFlash(
              child: Text(name, style: FontTheme.of(context).big()),
            )
          : Text(
              name,
              key: keyTitle,
              style: FontTheme.of(context).big(),
            ),
      subtitle: loading
          ? loadingFlash(
              child: Text(
                position,
                style: FontTheme.of(context).middle.secondary(),
              ),
            )
          : Text(
              position,
              key: keySubtitle,
              style: FontTheme.of(context).middle.secondary(),
            ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
