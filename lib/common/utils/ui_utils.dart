import 'package:flutter/material.dart';

class UiUtils {
  UiUtils._internal();

  static Widget buildSafeBottom(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return SizedBox(height: padding.bottom);
  }
}
