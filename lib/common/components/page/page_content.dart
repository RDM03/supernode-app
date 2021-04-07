import 'package:flutter/material.dart';

Widget pageContent(String text, {double top: 50}) {
  return Container(
    margin: EdgeInsets.only(top: top),
    alignment: Alignment.center,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(139, 0, 0, 0),
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.none,
        fontSize: 14,
        height: 1.42857,
      ),
    ),
  );
}
