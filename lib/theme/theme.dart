import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final colorsMapper = ColorsTheme._(); // todo

final lightThemeColors = ColorsTheme._(); // todo
final darkThemeColors = ColorsThemeDark._(); // todo

class ThemeMapper extends StatelessWidget {
  const ThemeMapper({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorsTheme = context.watch<ColorsTheme>();
    return Theme(
      data: ThemeData(
        brightness:
            colorsTheme is ColorsThemeDark ? Brightness.dark : Brightness.light,
        bottomAppBarColor: colorsTheme.secondaryBackground,
        scaffoldBackgroundColor: colorsTheme.primaryBackground,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorsTheme.secondaryBackground,
          selectedItemColor: colorsTheme.mxcBlue,
          unselectedItemColor: colorsTheme.textSecondary,
        ),
        iconTheme: IconThemeData(
          color: colorsTheme.textPrimaryAndIcons,
        ),
      ),
      child: child,
    );
  }
}

class ColorsTheme {
  ColorsTheme._();

  static ColorsTheme of(BuildContext context) {
    return Provider.of<ColorsTheme>(context);
  }

  // background
  final primaryBackground = const Color(0xFFEBEFF2);
  final secondaryBackground = Colors.white;

  // components
  final boxComponents = Colors.white;
  final mxcBlue = const Color(0xFF1C1478);
  Color get mxcBlue80 => mxcBlue;
  Color get mxcBlue60 => mxcBlue;
  Color get mxcBlue40 => mxcBlue;
  Color get mxcBlue20 => mxcBlue;
  final dhxBlue = const Color(0xFF4665EA);
  Color get dhxBlue80 => dhxBlue;
  Color get dhxBlue60 => dhxBlue;
  Color get dhxBlue40 => dhxBlue;
  Color get dhxBlue20 => dhxBlue;
  final dhxPurple = const Color(0xFF7D06AF);
  final minerHealthRed = const Color(0xFFFF5B5B);
  Color get minerHealthRed80 => minerHealthRed;
  Color get minerHealthRed20 => minerHealthRed;
  final btcYellow = const Color(0xFFF7931A);

  final textPrimaryAndIcons = Colors.black.withOpacity(0.87);
  final textSecondary = const Color(0xFF98A6AD);
  final textLabel = const Color(0xFF98A6AD);
  final textError = const Color(0xFFFF5B5B);
}

class ColorsThemeDark implements ColorsTheme {
  ColorsThemeDark._();

  // background
  final primaryBackground = const Color(0xFF111111);
  final secondaryBackground = const Color(0xFF1C1C1E);

  // components
  final boxComponents = const Color(0xFF2C2C2E);
  final mxcBlue = const Color(0xFF30A78B);
  final mxcBlue80 = const Color(0xFF30A78B).withOpacity(0.8);
  final mxcBlue60 = const Color(0xFF30A78B).withOpacity(0.6);
  final mxcBlue40 = const Color(0xFF30A78B).withOpacity(0.4);
  final mxcBlue20 = const Color(0xFF30A78B).withOpacity(0.2);
  final dhxBlue = const Color(0xFF7B90E9);
  final dhxBlue80 = const Color(0xFF7B90E9).withOpacity(0.8);
  final dhxBlue60 = const Color(0xFF7B90E9).withOpacity(0.6);
  final dhxBlue40 = const Color(0xFF7B90E9).withOpacity(0.4);
  final dhxBlue20 = const Color(0xFF7B90E9).withOpacity(0.2);
  final dhxPurple = const Color(0xFFD164FF);
  final minerHealthRed = const Color(0xFFFF7878);
  final minerHealthRed80 = const Color(0xFFFF7878).withOpacity(0.8);
  final minerHealthRed20 = const Color(0xFFFF7878).withOpacity(0.2);
  final btcYellow = const Color(0xFFB1742A);

  final textPrimaryAndIcons = Colors.white;
  final textSecondary = const Color(0xFFEBEFF2);
  final textLabel = const Color(0xFF98A6AD);
  final textError = const Color(0xFFFF5B5B);
}
