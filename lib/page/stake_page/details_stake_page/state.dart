import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';

class DetailsStakeState implements Cloneable<DetailsStakeState> {
  Stake stake;
  bool isDemo;
  bool otpEnabled = false;

  @override
  DetailsStakeState clone() {
    return DetailsStakeState()
      ..stake = stake
      ..isDemo = isDemo
      ..otpEnabled = otpEnabled;
  }
}

DetailsStakeState initState(Map<String, dynamic> args) {
  Stake stake = args['stake'];
  bool isDemo = args['isDemo'] ?? false;

  return DetailsStakeState()
    ..stake = stake
    ..isDemo = isDemo;
}
