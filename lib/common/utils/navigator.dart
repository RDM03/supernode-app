import 'package:flutter/material.dart';

bool isCurrent(NavigatorState n, String routeName) {
  bool isCurrent = false;
  n.popUntil((route) {
    if (route.settings.name == routeName) {
      isCurrent = true;
    }
    return true;
  });
  return isCurrent;
}

void popPage(BuildContext context, {int count = 1}) {
  for (var i = 0; i < count; i++) {
    if (Navigator.of(context).canPop()) Navigator.of(context).pop();
  }
}