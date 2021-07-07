import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/currencies.dart';

import 'colors.dart';

class MiddleFontOfColor extends TextStyle {
  final Color color;

  MiddleFontOfColor({this.color = const Color.fromARGB(222, 0, 0, 0)}) {
    TextStyle(
      color: color,
      fontFamily: "Roboto",
      fontSize: 15,
      height: 1.5,
    );
  }
}

final kSmallFontOfDhxColor = TextStyle(
    color: Token.supernodeDhx.color,
    fontFamily: "Roboto",
    fontSize: 12,
    height: 1.33333,
    decoration: TextDecoration.none);

const kSmallFontOfWhite = TextStyle(
    color: whiteColor,
    fontFamily: "Roboto",
    fontSize: 12,
    height: 1.33333,
    decoration: TextDecoration.none);

const kSmallFontOfBlack = TextStyle(
    color: blackColor,
    fontFamily: "Roboto",
    fontSize: 12,
    height: 1.33333,
    decoration: TextDecoration.none);

const kSmallFontOfGrey = TextStyle(
    color: const Color.fromARGB(138, 0, 0, 0),
    fontFamily: "Roboto",
    fontSize: 12,
    height: 1.33333,
    decoration: TextDecoration.none);

const kSmallFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

const kSmallFontOfRed = TextStyle(
  color: Color.fromARGB(255, 255, 91, 91),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

const kSmallFontOfDarkBlue = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  fontSize: 12,
  height: 1.33333,
);

const kMiddleFontODarkBlue = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfGrey = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfGreyLink = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  decoration: TextDecoration.underline,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfBlue = TextStyle(
  color: Colors.blue,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfBlueLink = TextStyle(
  color: const Color.fromARGB(255, 27, 20, 120),
  decoration: TextDecoration.underline,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kMiddleFontOfDarkBlueLink = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  decoration: TextDecoration.underline,
  fontSize: 14,
);

const kBigFontOfDarkBlueLink = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  decoration: TextDecoration.underline,
  fontSize: 16,
);

const kMiddleFontOfGreen = TextStyle(
  color: const Color.fromARGB(255, 16, 196, 105),
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfRed = TextStyle(
  color: Colors.red,
  fontFamily: "Roboto",
  fontSize: 14,
  height: 1.33333,
);

const kMiddleFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 15,
  height: 1.5,
);

const kMiddleFontOfWhite = TextStyle(
  color: const Color.fromARGB(255, 255, 255, 255),
  fontFamily: "Roboto",
  fontSize: 15,
  height: 1.5,
);

final kBigFontOfDhxColor = TextStyle(
  color: Token.supernodeDhx.color,
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

final kSmallBoldFontOfBlack =
    kSmallFontOfBlack.copyWith(fontWeight: FontWeight.w600);

final TextStyle kMiddleBoldFontOfBlack =
    kMiddleFontOfBlack.copyWith(fontWeight: FontWeight.w600);

final TextStyle kBigBoldFontOfBlack =
    kBigFontOfBlack.copyWith(fontWeight: FontWeight.w600);

const kVeryBigFontOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 24,
);

final TextStyle kVeryBigBoldFontOfBlack =
    kVeryBigFontOfBlack.copyWith(fontWeight: FontWeight.w600);

const kBigFontOfBlue = TextStyle(
  color: const Color.fromARGB(255, 77, 137, 229),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfWhite = TextStyle(
  color: whiteColor,
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfRed = TextStyle(
  color: Colors.red,
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfDarkBlue = TextStyle(
  color: const Color.fromARGB(255, 28, 20, 120),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kBigFontOfGrey = TextStyle(
  color: const Color.fromARGB(138, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 16,
  height: 1.5,
);

const kSecondaryButtonOfPurple = TextStyle(
  color: buttonPrimaryColor,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kSecondaryButtonOfBlack = TextStyle(
  color: const Color.fromARGB(222, 0, 0, 0),
  fontFamily: "Roboto",
  fontSize: 14,
);

const kSecondaryButtonOfWhite = TextStyle(
  color: whiteColor,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kSecondaryButtonOfGrey = TextStyle(
  color: greyColor,
  fontFamily: "Roboto",
  fontSize: 14,
);

const kRowShodow = BoxDecoration(
  color: panelColor,
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
      color: shodowColor,
      offset: Offset(0, 2),
      blurRadius: 7,
    ),
  ],
);

const kPrimaryBigFontOfBlack =
    TextStyle(fontSize: 18, fontWeight: FontWeight.w600);

const kSuperBigBoldFont =
    TextStyle(color: blackColor, fontSize: 22, fontWeight: FontWeight.w600);
