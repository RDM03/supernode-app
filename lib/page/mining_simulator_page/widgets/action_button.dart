import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'package:supernodeapp/theme/font.dart';
import 'package:supernodeapp/theme/theme.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool primary;

  const ActionButton({
    Key key,
    this.text,
    this.onTap,
    this.primary = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        text,
        style: primary
            ? FontTheme.of(context).middle.label()
            : FontTheme.of(context).middle(),
      ),
      onPressed: onTap,
      color: primary
          ? colorSupernodeDhx
          : ColorsTheme.of(context).primaryBackground,
    );
  }
}

class SmallActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool primary;
  final double width;

  const SmallActionButton({
    Key key,
    this.text,
    this.onTap,
    this.primary = true,
    this.width = 90,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primary
            ? colorSupernodeDhx
            : ColorsTheme.of(context).primaryBackground,
      ),
      height: 25,
      width: width,
      child: InkWell(
        child: Center(
          child: Text(
            text,
            style: FontTheme.of(context).small.secondary(),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
