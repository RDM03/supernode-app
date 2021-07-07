import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

Widget submitButton(
  String label, {
  double top = 34,
  Function onPressed,
  Key key,
}) {
  return Container(
    height: 45,
    width: double.infinity,
    margin: EdgeInsets.only(top: top),
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

Widget whiteBorderButton(
  String label, {
  double top = 34,
  Function onPressed,
  Key key,
}) {
  final Color color = (onPressed == null) ? greyColor : whiteColor;
  return Container(
    height: 45,
    margin: EdgeInsets.only(top: top),
    child: FlatButton(
      key: key,
      onPressed: onPressed,
      color: Color.fromARGB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: color,
          width: 1,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      textColor: color,
      padding: EdgeInsets.all(0),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
}
