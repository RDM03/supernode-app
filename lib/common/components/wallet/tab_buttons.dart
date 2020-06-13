import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget tabButtons({BuildContext context,TabController tabController,List list,double height = 90,List<Widget> children,Function(int) onTap}){

  return DefaultTabController(
    length: list.length,
    child: Column(
      children: [
        TabBar(
          controller: tabController,
          indicatorPadding: EdgeInsets.zero,
          indicatorColor: buttonPrimaryColor,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black38,
          tabs: list.map((item) {
            return Tab(
              text: FlutterI18n.translate(context, item),
            );
          }).toList(),
          onTap: onTap
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.grey,
                width: 1
              )
            ),
          ),
        ),
        Container(
          height: height,
          // constraints: BoxConstraints(
          //   minHeight: 120
          // ),
          decoration: BoxDecoration(
            color: panelColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: shodowColor,
                offset: Offset(0, 2),
                blurRadius: 7,
              ),
            ],
          ),
          child: OverflowBox(
            maxHeight: 140,
            child: TabBarView(
              controller: tabController,
              children: children
            )
          ),
        ),
      ]
    )
  );
}