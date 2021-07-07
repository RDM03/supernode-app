import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

import 'package:supernodeapp/theme/font.dart';

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
        style: primary ? kMiddleFontOfWhite : kMiddleFontOfBlack,
      ),
      onPressed: onTap,
      color: primary ? colorSupernodeDhx : darkBackground,
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
        color: primary ? colorSupernodeDhx : darkBackground,
      ),
      height: 25,
      width: width,
      child: InkWell(
        child: Center(
          child: Text(
            text,
            style: kSmallFontOfWhite,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
