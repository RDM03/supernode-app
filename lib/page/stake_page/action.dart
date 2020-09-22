import 'package:fish_redux/fish_redux.dart';

enum StakeAction {
  setRates,
  balance
}

class StakeActionCreator {
  static Action setRates({
    double rateFlex,
    double rate6Months,
    double rate9Months,
    double rate12Months,
    double rate24Months,
  }) {
    return Action(StakeAction.setRates, payload: {
      '6': rate6Months,
      '9': rate9Months,
      '12': rate12Months,
      '24': rate24Months,
      'flex': rateFlex,
    });
  }

  static Action balance(double balance) {
    return Action(StakeActionCreator.balance, payload: balance);
  }
}
