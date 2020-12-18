import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/dhx.dart';

class LockState implements Cloneable<LockState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo = false;

  double boost24m;
  double boost12m;
  double boost9m;
  double boost3m;

  @override
  LockState clone() {
    return LockState()
      ..isDemo = isDemo
      ..boost24m = boost24m
      ..boost12m = boost12m
      ..boost9m = boost9m
      ..boost3m = boost3m;
  }
}

LockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;

  return LockState()
    ..boost24m = boost24months
    ..boost12m = boost12months
    ..boost9m = boost9months
    ..boost3m = boost3months
    ..isDemo = isDemo;
}
