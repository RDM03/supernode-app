import 'dart:math';

import 'package:flutter/foundation.dart';

const double boost3months = 0.0;
const double boost9months = 0.1;
const double boost12months = 0.2;
const double boost24months = 0.4;
List<int> get monthsOptions => [3, 9, 12, 24];

double monthsToBoost(int months) {
  switch (months) {
    case 3:
      return boost3months;
    case 9:
      return boost9months;
    case 12:
      return boost12months;
    case 24:
      return boost24months;
    default:
      return null;
  }
}

double getMinersBoost(double mxcValue, int minersCount) {
  return min(mxcValue, minersCount * 1000000.0);
}

double calculateDhxDaily({
  @required double mxcLocked,
  @required int minersCount,
  @required double dhxBonded,
  @required double yesterdayMining,
  @required int months,
}) {
  final mPower = mxcLocked == null || minersCount == null
      ? null
      : calculateMiningPower(mxcLocked, minersCount, monthsToBoost(months));

  return mPower == null || dhxBonded == null || yesterdayMining == null
      ? null
      : min(5000, dhxBonded/70);//your bonded DHX is a limit, even if you mined more DHX based on your mPower you could get only the maximum of DHX_bonded/70 per day
}

double calculateMiningPower(
    double mxcValue, int minersCount, double monthsBoostRate) {
  var miningPower = mxcValue + mxcValue * monthsBoostRate;
  miningPower = miningPower + getMinersBoost(miningPower, minersCount);
  return miningPower;
}
