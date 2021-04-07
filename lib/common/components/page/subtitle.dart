import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/font.dart';

Widget subtitle(String name) {
  return Container(
    margin: const EdgeInsets.only(top: 30),
    child: Text(
      name,
      textAlign: TextAlign.left,
      style: kSmallFontOfGrey,
    ),
  );
}
