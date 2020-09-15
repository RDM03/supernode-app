import 'package:flutter/material.dart';

Widget submitButton(String label,
    {double top = 34, Function onPressed, Key key}) {
  return Container(
    height: 45,
    width: double.infinity,
    margin: EdgeInsets.only(top: top),
    key: key,
    child: FlatButton(
      key: key,
      onPressed: onPressed,
      color: Color.fromARGB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color.fromARGB(255, 28, 20, 120),
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      textColor: Color.fromARGB(255, 28, 20, 120),
      padding: EdgeInsets.all(0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromARGB(255, 28, 20, 120),
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
}
