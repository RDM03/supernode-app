import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/utils/dhx.dart';

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
  double yesterdayTotalMPower;
  double yesterdayTotalDHX;
  bool mPowerExpand;
  bool dailyMiningExpand;
  bool bondExpand;

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
      ..yesterdayTotalMPower = yesterdayTotalMPower
      ..yesterdayTotalDHX = yesterdayTotalDHX
      ..mPowerExpand = mPowerExpand
      ..dailyMiningExpand = dailyMiningExpand
      ..bondExpand = bondExpand;
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
    ..mPowerExpand = false
    ..bondExpand = false
    ..dailyMiningExpand = false;
}
