import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';
import 'package:supernodeapp/theme/theme.dart';

// RETHINK.QUESTION what is the panel frame? mb rename?,
class PanelFrame extends StatelessWidget {
  final double height;
  final Widget child;
  final EdgeInsetsGeometry rowTop;
  final Color customPanelColor;

  const PanelFrame({
    Key key,
    this.height,
    this.rowTop,
    this.customPanelColor,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      height: height,
      margin: rowTop != null ? rowTop : kOuterRowTop20,
      decoration: BoxDecoration(
        color: customPanelColor == null
            ? ColorsTheme.of(context).secondaryBackground
            : customPanelColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: boxShadowColor,
            offset: Offset(0, 2),
            blurRadius: 7,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
