import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class JoinCouncilState implements Cloneable<JoinCouncilState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo;
  bool resSuccess;

  @override
  JoinCouncilState clone() {
    return JoinCouncilState()
      ..scaffoldKey = scaffoldKey
      ..isDemo = isDemo
      ..resSuccess = resSuccess;
  }
}

JoinCouncilState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  return JoinCouncilState()..isDemo = isDemo;
}
