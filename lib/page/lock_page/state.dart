import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class LockState implements Cloneable<LockState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo = false;
  double balance;

  double boost24m;
  double boost12m;
  double boost9m;
  double boost3m;

  @override
  LockState clone() {
    return LockState()
      ..balance = balance
      ..isDemo = isDemo
      ..boost24m = boost24m
      ..boost12m = boost12m
      ..boost9m = boost9m
      ..boost3m = boost3m;
  }
}

LockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  double balance = args['balance'] ?? 0;

  return LockState()
    ..boost24m = 0.40
    ..boost12m = 0.20
    ..boost9m = 0.10
    ..boost3m = 0
    ..isDemo = isDemo
    ..balance = balance;
}
