import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';
import 'package:toast/toast.dart';

void tip(context, text, {bool success: false, int duration = 5}) {
  Toast.show(text.runtimeType == String ? text : text.toString(), context,
      duration: duration,
      gravity: Toast.BOTTOM,
      backgroundColor: success ? Colors.green : errorColor);
}
