import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

class Link extends StatelessWidget {
  final String text;
  final Function onTap;
  final AlignmentGeometry alignment;
  final EdgeInsets padding;

  const Link(
    this.text, {
    Key key,
    this.onTap,
    this.alignment = Alignment.centerRight,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: key,
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: alignment,
        child: Container(
          padding: padding ?? EdgeInsets.zero,
          child: Container(
            margin: kOuterRowTop5,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: FontTheme.of(context).middle.mxc.underline(),
            ),
          ),
        ),
      ),
    );
  }
}
