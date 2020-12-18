import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/mining_simulator_page/state.dart';

enum MiningSimulatorAction {
  mxcTotal,
  minersTotal,
  months,
  lastMining,
  expandCalculation,
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

  static Action lastMining(double totalDhx, double lastMining) {
    return Action(MiningSimulatorAction.lastMining,
        payload: [totalDhx, lastMining]);
  }

  static Action expandCalculation(CalculateExpandState state) {
    return Action(MiningSimulatorAction.expandCalculation, payload: state);
  }
}
