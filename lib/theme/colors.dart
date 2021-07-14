import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  // secondaryHeaderColor: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(brightness: Brightness.light),
);

@deprecated
const borderColor = const Color(0x46000000);

// wallet page
@deprecated
final withdrawColor = Colors.red[200];
@deprecated
const depositColor = const Color(0x3310C469);

const loginDhxGradientStart = Color(0xFF6B0B92);
const loginDhxGradientEnd = Color(0xFF4665EA);

const loginMxcGradientStart = Color(0xFF02FFD8);
const loginMxcGradientEnd = Color(0xFF1C1478);

// login
const Color darkBackground2 = Color(0xFFDBDFE2);
const Color hintFont = Color(0xFF98A6AD);
final Color hintFont20 = Color(0xFF98A6AD).withOpacity(0.2);
const Color tipFont = Color(0xDE000000);

//device
const dbm100 = Color(0xFFFF5B5B);
const dbm100_105 = Color(0xFFFAA300);
const dbm105_110 = Color(0xFFF7D700);

const dbm110_115 = Color(0xFF10C469);
const dbm115_120 = Color(0xFF4D89E5);
const dbm120 = Color(0xFF1C1478);

const boxShadowColor = Color.fromRGBO(0, 0, 0, 0.1);
final barrierColor = Colors.black.withOpacity(0.4);

@deprecated
// used for tip
final errorColor = Colors.red[200];

//miner
const unknownColor1 = Color(0x1A000000);
const unknownColor2 = Color(0x0000001A);
const unknownColor3 = Color(0xFF343434);
const unknownColor4 = Color(0x33000000);

@deprecated
const whiteColor = Colors.white;

const greyColor = Colors.grey; // used 63 times

// loading list colors
@deprecated
final whiteColor70 = Colors.white.withOpacity(0.7);
@deprecated
final blackColor12 = Colors.black.withOpacity(0.12);
final greyColorShade100 = greyColor.shade100;
final greyColorShade300 = greyColor.shade300;
