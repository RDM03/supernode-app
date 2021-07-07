import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/theme/colors.dart';

class PrepareLockState implements Cloneable<PrepareLockState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountCtl = TextEditingController();

  bool resSuccess = false;
  bool isDemo = false;

  int months;
  double boostRate;
  double balance;
  Color iconColor;

  double yesterdayTotalDHX;
  double yesterdayTotalMPower;

  int minersOwned;

  @override
  PrepareLockState clone() {
    return PrepareLockState()
      ..formKey = formKey
      ..amountCtl = amountCtl
      ..resSuccess = resSuccess
      ..isDemo = isDemo
      ..months = months
      ..balance = balance
      ..iconColor = iconColor
      ..boostRate = boostRate
      ..minersOwned = minersOwned
      ..yesterdayTotalDHX = yesterdayTotalDHX
      ..yesterdayTotalMPower = yesterdayTotalMPower;
  }
}

PrepareLockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  int months = args['months'];
  double boostRate = args['boostRate'];
  Color iconColor = args['iconColor'] ?? colorMxc;
  return PrepareLockState()
    ..isDemo = isDemo
    ..months = months
    ..iconColor = iconColor
    ..boostRate = boostRate
    ..amountCtl = TextEditingController(text: '0')
    ..minersOwned;
}
