import 'package:fish_redux/fish_redux.dart';

class CalculatorState implements Cloneable<CalculatorState> {
  double balance;
  double staking;
  double mining;

  bool isDemo;

  @override
  CalculatorState clone() {
    return CalculatorState()
      ..balance = balance
      ..staking = staking
      ..mining = mining
      ..isDemo = isDemo;
  }
}

CalculatorState initState(Map<String, dynamic> args) {
  final state = CalculatorState();
  state.staking = args['staking'] ?? 0.0;
  state.mining = args['mining'] ?? 0.0;
  state.balance = args['balance'] ?? 0.0;
  state.isDemo = args['isDemo'] ?? false;
  return state;
}
