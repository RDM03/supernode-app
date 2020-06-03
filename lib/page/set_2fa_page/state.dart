import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class Set2FAState implements Cloneable<Set2FAState> {

  GlobalKey formKey = GlobalKey<FormState>();
  //TextEditingController oldPwdCtl = TextEditingController();

  bool isEnabled = true;


  @override
  Set2FAState clone() {
    return Set2FAState()
      ..formKey = formKey
      ..isEnabled = isEnabled;
  }
}

Set2FAState initState(Map<String, dynamic> args) {
  bool isEnabled = true;
print('start');
  print(args);
  print('start');
  return Set2FAState()
    ..isEnabled = isEnabled;
}
