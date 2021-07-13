import 'package:flutter/material.dart';

import 'theme.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.blue,
  // secondaryHeaderColor: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(brightness: Brightness.light),
);

// final ColorsTheme.of(context).primaryBackground = colorsMapper.primaryBackground;
// final ColorsTheme.of(context).secondaryBackground = colorsMapper.secondaryBackground;
// final mxcBlue = colorsMapper.mxcBlue;
// final colorMxc05 = Color(0xFF1C1478).withOpacity(0.05);
// final ColorsTheme.of(context).dhxBlue = colorsMapper.dhxBlue;
// final colorBtc = colorsMapper.btcYellow;
// final boxComponents = colorsMapper.boxComponents;

// @deprecated
// const buttonPrimaryColorAccent = Color(0x961C1478);

//home
@deprecated
const lightBlue = Color(0xFFDAE7FB);

@deprecated
const shodowColor = const Color(0x1A000000);
@deprecated
const borderColor = const Color(0x46000000);
@deprecated
final withdrawColor = Colors.red[200];
@deprecated
const depositColor = const Color(0x3310C469);

//wallet
const colorMxcGradientStart = Color(0xFF02FFD8);
final colorSupernodeDhx20 = Color(0xFF4665EA).withOpacity(0.2);
const colorDhx = Color(0xFF6B0B92);
final colorDhx85 = Color(0xFF6B0B92).withOpacity(0.85);
const colorNtf = Color(0xFF04074e);
const transparentWhite = Color(0x00FFFFFF);

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

final errorColor = Colors.red[200];

final stake24Color = Color(0xFF1C1478);
final stake12Color = Color(0xFF494393);
final stake9Color = Color(0xFF7772AE);
final stake6Color = Color(0xFFA4A1C9);
final stakeFlexColor = Color(0xFFD2D0E4);

final lock24Color = Color(0xFF4D64E2);
final lock12Color = Color(0xFF7183E7);
final lock9Color = Color(0xFF94A2EC);
final lock3Color = Color(0xFFADB5E4);

//miner
final minerColor = colorsMapper.mxcBlue;
final minerColor10 = minerColor.withOpacity(0.1);
final fuelColor = healthColor;
const healthColor = Color(0xCCFF5B5B);
final healthColor20 = Color(0xCCFF5B5B).withOpacity(0.2);

const unknownColor1 = Color(0x1A000000);
const unknownColor2 = Color(0x0000001A);
const unknownColor3 = Color(0xFF343434);
const unknownColor4 = Color(0x33000000);

const whiteColor = Colors.white;
final whiteColor05 = Colors.white.withOpacity(0.5);
final whiteColor70 = Colors.white.withOpacity(0.7);
const blackColor = Colors.black;
final blackColor10 = blackColor.withOpacity(0.1);
final blackColor12 = blackColor.withOpacity(0.12);
final blackColor20 = blackColor.withOpacity(0.2);
final blackColor40 = blackColor.withOpacity(0.4);
final blackColor70 = blackColor.withOpacity(0.7);

const greyColor = Colors.grey; // used 63 times
final greyColor30 = greyColor.withOpacity(
    0.3); // it should be shadow 000000 25% - divider between elements in add token dialog
final greyColorShade050 = greyColor
    .shade50; // it should be shadow 000000 10.2% gateway list item on home screen
final greyColorShade100 =
    greyColor.shade100; // used for loading list and loading flesh animations
final greyColorShade200 = greyColor.shade200;
/*
send to wallet page - it should be shadow 000000 15% for `Send all` row and shadow 000000 25% for `Send amount` box
send to wallet page filter dialog - (we should remove this dialog, because we can't filter) - used instead of shadow for tiles
miner detail page - used as foreground decoration for greyed-out disabled elements (like GPS, Altitude - something we don't yet support)
home page - used for disabled elements in bottom navigation bar (Gateway menu can be disabled if user logged in with DHX account and not supernode, for example, but we don't support DHX login yet)
add fuel page and add fuel filter dialog - look send to wallet case
address book page - used as border for tiles (i can't determine what is color defined in design for borders)
address book details page - used as border for delete button (i can't determine what is color defined in design for borders)
*/
final greyColorShade300 = greyColor.shade300;
/*
home page > wallet tab > add token dialog - defined for case which never happens
used for loading list and loading flesh animations
*/
final greyColorShade600 = greyColor.shade600;
/*
in 2fa pages used for next texts:
Get a verification code from the Authenticator
app, or use one of your backup codes
Verification Code
(i can't find 2fa pages in design)

address book details page - used for description text, in design TextPrimary used instead, we should change in app
address book page - used for description text, in design LableColor used instead, we should change in app
*/
final greyColorShade700 = greyColor.shade700;
/*
used in add fuel and send to wallet pages for inactive slider thumb color
*/
