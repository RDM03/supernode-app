import 'package:fish_redux/fish_redux.dart';

enum MiningSimulatorAction {
  mxcTotal,
  minersTotal,
  months,
}

class MiningSimulatorActionCreator {
  static Action mxcTotal(double mxc) {
    return Action(MiningSimulatorAction.mxcTotal, payload: mxc);
  }

  static Action minersTotal(int miners) {
    return Action(MiningSimulatorAction.minersTotal, payload: miners);
  }

  static Action months(int months) {
    return Action(MiningSimulatorAction.months, payload: months);
  }
}
