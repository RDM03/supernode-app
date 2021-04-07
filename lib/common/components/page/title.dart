import 'package:flutter/material.dart';

Widget title(String name) {
  return Center(
    child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Text(
          name,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color.fromARGB(222, 0, 0, 0),
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            decoration: TextDecoration.none,
            fontSize: 24,
            height: 1.33333,
          ),
        )),
  );
}
