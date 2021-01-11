import 'package:flutter/material.dart';

Widget paragraph(String text) {
  return Container(
    margin: EdgeInsets.only(top: 14),
    child: Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Color.fromARGB(222, 0, 0, 0),
        fontFamily: "Roboto",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
      ),
    ),
  );
}
