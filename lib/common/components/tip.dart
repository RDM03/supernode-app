import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:supernodeapp/theme/spacing.dart';

void tip(
  String text, {
  bool success: false,
  int seconds = 5,
}) {
  showToast(
    text.runtimeType == String ? text : text.toString(),
    textStyle: TextStyle(
      fontSize: 16
    ),
    textPadding: kRoundRow105,
    duration: Duration(seconds: seconds),
    position: ToastPosition.bottom,
    backgroundColor: success ? Colors.green : errorColor
  );
}
