import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/dhx.dart';

enum CalculateExpandState { notExpanded, dhx, mPower }

class MiningSimulatorState implements Cloneable<MiningSimulatorState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController mxcLockedCtl;
  TextEditingController minersAmountCtl;
  int months;
  TextEditingController dhxBondedCtl;
  double dhxFuel;
  bool isDemo = false;

  double mxcBalance;
  int minersTotal;

  double dhxBalance;
  double yesterdayMining;
  CalculateExpandState calculateExpandState;

  @override
  MiningSimulatorState clone() {
    return MiningSimulatorState()
      ..formKey = formKey
      ..mxcLockedCtl = mxcLockedCtl
      ..minersAmountCtl = minersAmountCtl
      ..months = months
      ..dhxFuel = dhxFuel
      ..isDemo = isDemo
      ..mxcBalance = mxcBalance
      ..minersTotal = minersTotal
      ..dhxBondedCtl = dhxBondedCtl
      ..dhxBalance = dhxBalance
      ..yesterdayMining = yesterdayMining
      ..calculateExpandState = calculateExpandState;
  }
}

MiningSimulatorState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  double mxcBalance = args['mxc_balance'] ?? 0;
  double dhxBalance = args['dhx_balance'] ?? 0;

  return MiningSimulatorState()
    ..isDemo = isDemo
    ..mxcLockedCtl = TextEditingController(text: '0')
    ..minersAmountCtl = TextEditingController(text: '0')
    ..months = monthsOptions.first
    ..dhxBondedCtl = TextEditingController(text: '')
    ..mxcBalance = mxcBalance
    ..dhxBalance = dhxBalance
    ..calculateExpandState = CalculateExpandState.notExpanded;
}
