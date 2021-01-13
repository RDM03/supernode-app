import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class PageBody extends StatelessWidget {
  final List<Widget> children;
  final bool useColumn;
  final bool usePadding;

  const PageBody({
    Key key,
    this.children,
    this.useColumn = false,
    this.usePadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageBodySingleChild(
      usePadding: usePadding,
      child: useColumn
          ? Column(
              children: children,
            )
          : ListView(
              children: children,
            ),
    );
  }
}

class PageBodySingleChild extends StatelessWidget {
  final Widget child;
  final bool usePadding;

  const PageBodySingleChild({
    Key key,
    this.child,
    this.usePadding = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: usePadding ? const EdgeInsets.symmetric(horizontal: 20) : null,
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
