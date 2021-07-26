import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget pageFrame({
  BuildContext context,
  List<Widget> children,
  EdgeInsetsGeometry padding,
  Key scaffoldKey,
  bool resizeToAvoidBottomInset = false,
  bool scrollable = true,
  bool useSafeArea = false,
  EdgeInsetsGeometry margin,
}) {
  Widget content = Container(
    padding: padding != null ? padding : const EdgeInsets.all(20.0),
    constraints:
        BoxConstraints(minHeight: MediaQuery.of(context).size.height - 20),
    decoration: BoxDecoration(
      color: ColorsTheme.of(context).secondaryBackground,
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      boxShadow: [
        BoxShadow(
          color: boxShadowColor,
          offset: Offset(0, 2),
          blurRadius: 7,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
  if (useSafeArea) content = SafeArea(child: content);
  return Scaffold(
    key: scaffoldKey,
    resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    body: Container(
      padding: margin,
      decoration: BoxDecoration(
        color: ColorsTheme.of(context).primaryBackground,
      ),
      child: Container(
        constraints: BoxConstraints.expand(),
        padding: const EdgeInsets.only(top: 20.0),
        child: scrollable
            ? ListView(
                children: [content],
              )
            : content,
      ),
    ),
  );
}
