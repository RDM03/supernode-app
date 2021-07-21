import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

class ColoredText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color color;
  final EdgeInsets padding;

  const ColoredText({
    Key key,
    this.text,
    this.style,
    this.textAlign = TextAlign.right,
    this.color,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? ColorsTheme.of(context).dhxBlue20,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: padding,
      child: Text(
        text,
        style: style,
        maxLines: 2,
        textAlign: textAlign,
      ),
    );
  }
}
