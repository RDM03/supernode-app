import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';
import 'package:supernodeapp/common/utils/dhx.dart';

class ConfirmLockState implements Cloneable<ConfirmLockState> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  bool isDemo;
  bool resSuccess;

  String amount;
  DateTime startDate;
  int months;
  int minersOwned;
  Council council;
  double avgDailyDhxRevenue;
  String get councilName => council.name;

  double get miningPower {
    return calculateMiningPower(
        double.tryParse(amount), minersOwned, boostRate);
  }

  DateTime openTime;
  double boostRate;

  DateTime get endDate => startDate == null || months == null
      ? null
      : startDate.add(Duration(days: 30 * months));

  @override
  ConfirmLockState clone() {
    return ConfirmLockState()
      ..scaffoldKey = scaffoldKey
      ..isDemo = isDemo
      ..resSuccess = resSuccess
      ..amount = amount
      ..startDate = startDate
      ..months = months
      ..minersOwned = minersOwned
      ..council = council
      ..openTime = openTime
      ..boostRate = boostRate
      ..avgDailyDhxRevenue = avgDailyDhxRevenue;
  }
}

ConfirmLockState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;

  String amount = args['amount'] ?? (throw ArgumentError.notNull('amount'));
  int months = args['months'] ?? (throw ArgumentError.notNull('months'));
  double boostRate =
      args['boostRate'] ?? (throw ArgumentError.notNull('boostRate'));

  DateTime startDate = args['startDate'] ?? DateTime.now();
  int minersOwned =
      args['minersOwned'] ?? (throw ArgumentError.notNull('minersOwned'));
  Council council = args['council'] ?? (throw ArgumentError.notNull('council'));

  double avgDailyDhxRevenue = args['avgDailyDhxRevenue'];

  return ConfirmLockState()
    ..isDemo = isDemo
    ..amount = amount
    ..months = months
    ..startDate = startDate
    ..minersOwned = minersOwned
    ..council = council
    ..openTime = DateTime.now()
    ..boostRate = boostRate
    ..avgDailyDhxRevenue = avgDailyDhxRevenue;
}
