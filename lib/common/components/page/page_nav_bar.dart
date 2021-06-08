import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget pageNavBar(
  String name, {
  EdgeInsetsGeometry padding,
  Function onTap,
  Widget actionWidget,
  Widget leadingWidget,
}) {
  return Container(
    padding: padding,
    child: Row(
      children: <Widget>[
        if (leadingWidget != null) ...[
          leadingWidget,
          Spacer(),
        ],
        Text(
          name,
          textAlign: TextAlign.left,
          style: kBigFontOfBlack,
        ),
        Spacer(),
        GestureDetector(
          key: ValueKey('navActionButton'),
          child: actionWidget == null
              ? Icon(
                  Icons.close,
                  color: Colors.black,
                )
              : actionWidget,
          onTap: onTap,
        ),
      ],
    ),
  );
}

class PageNavBar extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final EdgeInsetsGeometry padding;
  final Function onTap;
  final Widget actionWidget;
  final Widget leadingWidget;
  final bool centerTitle;

  const PageNavBar({
    Key key,
    @required this.text,
    this.padding,
    this.onTap,
    this.textStyle = kBigFontOfBlack,
    this.actionWidget,
    this.leadingWidget,
    this.centerTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Row(
        children: <Widget>[
          if (leadingWidget != null)
            leadingWidget
          else if (centerTitle)
            SizedBox(width: 24),
          Expanded(
            child: Text(
              text,
              textAlign: centerTitle ? TextAlign.center : TextAlign.left,
              style: textStyle,
            ),
          ),
          SizedBox(
            width: 24,
            child: GestureDetector(
              key: ValueKey('navActionButton'),
              child: actionWidget == null
                  ? Icon(
                      Icons.close,
                      color: Colors.black,
                    )
                  : actionWidget,
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}
