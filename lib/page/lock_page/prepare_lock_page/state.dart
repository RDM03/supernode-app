import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class PrepareLockState implements Cloneable<PrepareLockState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountCtl = TextEditingController();

  bool resSuccess = false;
  bool isDemo = false;

  int months;
  double boostRate;
  double balance;
  Color iconColor;

  double lastMiningDhx;
  double lastMiningMPower;

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
      ..lastMiningDhx = lastMiningDhx
      ..lastMiningMPower = lastMiningMPower;
  }
}

PrepareLockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  int months = args['months'];
  double boostRate = args['boostRate'];
  Color iconColor = args['iconColor'] ?? Color(0xFF1C1478);
  return PrepareLockState()
    ..isDemo = isDemo
    ..months = months
    ..iconColor = iconColor
    ..boostRate = boostRate
    ..amountCtl = TextEditingController(text: '0')
    ..minersOwned;
}
