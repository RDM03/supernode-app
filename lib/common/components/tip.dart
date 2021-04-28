import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

void tip(
  String text, {
  bool success: false,
  int duration = 5,
}) {
  Fluttertoast.showToast(
    msg: text.runtimeType == String ? text : text.toString(),
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: success ? Colors.green : errorColor,
  );
}
