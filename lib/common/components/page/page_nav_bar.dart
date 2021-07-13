import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

@deprecated
// Use [PageNavBar] instead
Widget pageNavBar(
  String name, {
  EdgeInsetsGeometry padding,
  Function onTap,
  Widget actionWidget,
  Widget leadingWidget,
}) {
  return Builder(
    builder: (context) => Container(
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
            style: FontTheme.of(context).big(),
          ),
          Spacer(),
          GestureDetector(
            key: ValueKey('navActionButton'),
            child: actionWidget == null
                ? Icon(
                    Icons.close,
                    color: blackColor,
                  )
                : actionWidget,
            onTap: onTap,
          ),
        ],
      ),
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
    this.textStyle,
    this.actionWidget = const Icon(
      Icons.close,
      color: blackColor,
    ),
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
              style: textStyle ?? FontTheme.of(context).big(),
            ),
          ),
          SizedBox(
            width: 24,
            child: actionWidget == null
                ? null
                : GestureDetector(
                    key: ValueKey('navActionButton'),
                    child: actionWidget,
                    onTap: onTap,
                  ),
          ),
        ],
      ),
    );
  }
}

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        key: ValueKey('navBackButton'),
        child: Icon(
          Icons.arrow_back_ios,
          color: blackColor,
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}
