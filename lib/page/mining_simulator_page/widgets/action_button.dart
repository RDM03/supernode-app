import 'package:flutter/material.dart';
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
      color: primary ? Color(0xFF4665EA) : Color(0xFFEBEFF2),
    );
  }
}

class SmallActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool primary;

  const SmallActionButton({
    Key key,
    this.text,
    this.onTap,
    this.primary = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: primary ? Color(0xFF4665EA) : Color(0xFFEBEFF2),
      ),
      height: 25,
      width: 90,
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
