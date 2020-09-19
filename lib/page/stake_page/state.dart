import 'package:fish_redux/fish_redux.dart';

class StakeState implements Cloneable<StakeState> {
  bool isDemo = false;
  double balance;

  double rate24m;
  double rate12m;
  double rate9m;
  double rate6m;
  double rateFlex;

  @override
  StakeState clone() {
    return StakeState()
      ..balance = balance
      ..isDemo = isDemo
      ..rate24m = rate24m
      ..rate12m = rate12m
      ..rate9m = rate9m
      ..rate6m = rate6m
      ..rateFlex = rateFlex;
  }
}

StakeState initState(Map<String, dynamic> args) {
  bool isDemo = args['isDemo'] ?? false;
  double balance = args['balance'] ?? 0;

  return StakeState()
    ..isDemo = isDemo
    ..balance = balance;
}
