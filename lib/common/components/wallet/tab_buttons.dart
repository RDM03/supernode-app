import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget tabButtons({
  BuildContext context,
  TabController tabController,
  List<String> list,
  double height = 90,
  List<Widget> children,
  Function(int) onTap,
  bool expandContent = false,
  EdgeInsets padding = const EdgeInsets.all(0),
}) {
  return DefaultTabController(
    length: list.length,
    child: Column(
      children: [
        Padding(
          padding: padding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TabBar(
                controller: tabController,
                indicatorPadding: EdgeInsets.zero,
                indicatorColor: ColorsTheme.of(context).mxcBlue,
                labelColor: ColorsTheme.of(context).textPrimaryAndIcons,
                unselectedLabelColor: Colors.black38,
                key: ValueKey('tabBar'),
                tabs: list.map((item) {
                  return Tab(
                    key: ValueKey('tabBar_$item'),
                    text: FlutterI18n.translate(context, item),
                  );
                }).toList(),
                onTap: onTap,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: greyColor, width: 1)),
                ),
              ),
            ],
          ),
        ),
        if (expandContent)
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: children,
            ),
          )
        else
          Container(
            height: height,
            // constraints: BoxConstraints(
            //   minHeight: 120
            // ),
            decoration: BoxDecoration(
              color: ColorsTheme.of(context).secondaryBackground,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: shodowColor,
                  offset: Offset(0, 2),
                  blurRadius: 7,
                ),
              ],
            ),
            child: expandContent
                ? TabBarView(
                    controller: tabController,
                    children: children,
                  )
                : OverflowBox(
                    maxHeight: 140,
                    child: TabBarView(
                      controller: tabController,
                      children: children,
                    ),
                  ),
          ),
      ],
    ),
  );
}
