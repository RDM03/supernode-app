import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget pageBody(
    {List<Widget> children, bool useColumn = false, bool usePadding = true}) {
  return Container(
    padding: usePadding ? const EdgeInsets.symmetric(horizontal: 20) : null,
    constraints: BoxConstraints.expand(),
    decoration: BoxDecoration(
      color: backgroundColor,
    ),
    child: useColumn
        ? Column(
            children: children,
          )
        : ListView(
            children: children,
          ),
  );
}

Widget pageBodySingleChild({Widget child, bool usePadding = true}) {
  return Container(
      padding: usePadding ? const EdgeInsets.symmetric(horizontal: 20) : null,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: child);
}
