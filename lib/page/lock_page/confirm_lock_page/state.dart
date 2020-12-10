import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class ConfirmLockState implements Cloneable<ConfirmLockState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo;
  bool resSuccess;

  @override
  ConfirmLockState clone() {
    return ConfirmLockState()
      ..scaffoldKey = scaffoldKey
      ..isDemo = isDemo
      ..resSuccess = resSuccess;
  }
}

ConfirmLockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  return ConfirmLockState()..isDemo = isDemo;
}
