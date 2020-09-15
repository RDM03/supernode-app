import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class PrepareStakeState implements Cloneable<PrepareStakeState> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController amountCtl = TextEditingController();

  bool resSuccess = false;
  bool isDemo = false;

  int months;
  double revenueRate;
  double get boostRate => ((revenueRate - 1) * 100).roundToDouble() / 100;
  double balance;
  Color iconColor;
  String stakeName;
  double rateFlex;
  double estimatedRate;
  int marketingBoost;

  DateTime get endDate {
    final curDate = DateTime.now();
    return months == null
        ? null
        : DateTime(curDate.year, curDate.month + months, curDate.day);
  }

  @override
  PrepareStakeState clone() {
    return PrepareStakeState()
      ..formKey = formKey
      ..amountCtl = amountCtl
      ..resSuccess = resSuccess
      ..isDemo = isDemo
      ..months = months
      ..revenueRate = revenueRate
      ..balance = balance
      ..iconColor = iconColor
      ..stakeName = stakeName
      ..rateFlex = rateFlex
      ..estimatedRate = estimatedRate
      ..marketingBoost = marketingBoost;
  }
}

PrepareStakeState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  double balance = args['balance'] ?? 0;
  int months = args['months'];
  double revenueRate = args['revenueRate'];
  Color iconColor = args['iconColor'] ?? Color(0xFF1C1478);
  String stakeName = args['stakeName'];
  double rateFlex = args['rateFlex'] ?? 0;
  int marketingBoost = args['marketingBoost'] ?? 1;
  final flexPercent = (rateFlex - 1) * 100;

  final boostRate = (((revenueRate - 1) * 100).roundToDouble() / 100);
  final estimatedRateFull = flexPercent + (flexPercent * boostRate);

  double estimatedRate = (estimatedRateFull * 1000).roundToDouble() / 1000;

  return PrepareStakeState()
    ..isDemo = isDemo
    ..balance = balance
    ..months = months
    ..revenueRate = revenueRate
    ..iconColor = iconColor
    ..stakeName = stakeName
    ..rateFlex = rateFlex
    ..estimatedRate = estimatedRate
    ..marketingBoost = marketingBoost
    ..amountCtl = TextEditingController(text: '0');
}
