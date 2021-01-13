import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/dhx.dart';

enum CalculateExpandState { notExpanded, dhx, mPower }

class MiningSimulatorState implements Cloneable<MiningSimulatorState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mxcAmountCtl;
  TextEditingController minersAmountCtl;
  int months;
  TextEditingController dhxFuelCtl;
  double dhxFuel;
  bool isDemo = false;

  double mxcTotal;
  int minersTotal;

  double dhxTotal;
  double yesterdayMining;
  CalculateExpandState calculateExpandState;

  @override
  MiningSimulatorState clone() {
    return MiningSimulatorState()
      ..formKey = formKey
      ..mxcAmountCtl = mxcAmountCtl
      ..minersAmountCtl = minersAmountCtl
      ..months = months
      ..dhxFuel = dhxFuel
      ..isDemo = isDemo
      ..mxcTotal = mxcTotal
      ..minersTotal = minersTotal
      ..dhxFuelCtl = dhxFuelCtl
      ..dhxTotal = dhxTotal
      ..yesterdayMining = yesterdayMining
      ..calculateExpandState = calculateExpandState;
  }
}

MiningSimulatorState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  double balance = args['balance'] ?? 0;

  return MiningSimulatorState()
    ..isDemo = isDemo
    ..mxcAmountCtl = TextEditingController(text: '0')
    ..minersAmountCtl = TextEditingController(text: '0')
    ..months = monthsOptions.first
    ..dhxFuelCtl = TextEditingController(text: '')
    ..mxcTotal = balance
    ..calculateExpandState = CalculateExpandState.notExpanded;
}