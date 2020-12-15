import 'dart:math';

const double boost3months = 0.0;
const double boost9months = 0.1;
const double boost12months = 0.2;
const double boost24months = 0.4;

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

double minersBoost(double mxcValue, int minersCount) {
  return min(minersCount * mxcValue, minersCount * 1000000.0);
}

double calculateMiningPower(double mxcValue, int minersCount, double boost) {
  return (mxcValue + minersBoost(mxcValue, minersCount) * (boost + 1))
      .floorToDouble();
}
