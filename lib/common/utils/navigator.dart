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
