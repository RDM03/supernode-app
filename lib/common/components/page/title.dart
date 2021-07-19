import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/theme.dart';

Widget title(String name) {
  return Builder(
    builder: (context) => Center(
      child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: ColorsTheme.of(context).textPrimaryAndIcons,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
              fontSize: 24,
              height: 1.33333,
            ),
          )),
    ),
  );
}
