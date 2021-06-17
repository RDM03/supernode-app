import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/mining_simulator_page/state.dart';

enum MiningSimulatorAction {
  minersTotal,
  months,
  lastMining,
  expandCalculation,
  expandDailyMining,
  expandBond,
}

class MiningSimulatorActionCreator {
  static Action minersTotal(int miners) {
    return Action(MiningSimulatorAction.minersTotal, payload: miners);
  }

  static Action months(int months) {
    return Action(MiningSimulatorAction.months, payload: months);
  }

  static Action lastMining(
      double yesterdayTotalMPower, double yesterdayTotalDHX) {
    return Action(MiningSimulatorAction.lastMining,
        payload: [yesterdayTotalMPower, yesterdayTotalDHX]);
  }

  static Action expandCalculation(bool state) {
    return Action(MiningSimulatorAction.expandCalculation, payload: state);
  }

  static Action expandDailyMining(bool state) {
    return Action(MiningSimulatorAction.expandDailyMining, payload: state);
  }

  static Action expandBond(bool state) {
    return Action(MiningSimulatorAction.expandBond, payload: state);
  }
}
