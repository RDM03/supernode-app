import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget pageBody({List<Widget> children}){
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: backgroundColor,
      ),
      child: ListView(
        children: children,
      )
  );
}