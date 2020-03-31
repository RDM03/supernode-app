import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.grey,
  secondaryHeaderColor: Colors.pink,
);

//Text Styles
const kTitleTextStyle1 = TextStyle(
  color: Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
const kTitleTextStyle2 = TextStyle(
  color: Color.fromARGB(255, 255, 255, 255),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
const kTitleTextStyle3 = TextStyle(
  color: buttonPrimaryColor,
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 14,
);
const kInputTextStyle = TextStyle(
  color: Color.fromARGB(64, 0, 0, 0),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 12,
);
const kForgotPasswordTextStyle = TextStyle(
  color: Color.fromARGB(138, 0, 0, 0),
  fontFamily: "Roboto",
  fontWeight: FontWeight.w400,
  fontSize: 12,
);