import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

class ColoredText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign textAlign;
  final Color color;

  const ColoredText({
    Key key,
    this.text,
    this.style = kMiddleFontOfGrey,
    this.textAlign = TextAlign.right,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? Color(0x4665EA).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Text(
        text,
        style: style,
        maxLines: 2,
        textAlign: textAlign,
      ),
    );
  }
}
