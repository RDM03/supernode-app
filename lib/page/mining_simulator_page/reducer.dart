import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MiningSimulatorState> buildReducer() {
  return asReducer(
    <Object, Reducer<MiningSimulatorState>>{
      MiningSimulatorAction.minersTotal: _minersTotal,
      MiningSimulatorAction.months: _months,
      MiningSimulatorAction.lastMining: _lastMining,
      MiningSimulatorAction.expandCalculation: _expandCalculation,
      MiningSimulatorAction.expandDailyMining: _expandDailyMining,
      MiningSimulatorAction.expandBond: _expandBond,
    },
  );
}

MiningSimulatorState _minersTotal(MiningSimulatorState state, Action action) {
  int val = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..minersTotal = val;
}

MiningSimulatorState _months(MiningSimulatorState state, Action action) {
  int val = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..months = val;
}

MiningSimulatorState _lastMining(MiningSimulatorState state, Action action) {
  double yesterdayTotalMPower = action.payload[0];
  double yesterdayTotalDHX = action.payload[1];

  final MiningSimulatorState newState = state.clone();
  return newState
    ..yesterdayTotalMPower = yesterdayTotalMPower
    ..yesterdayTotalDHX = yesterdayTotalDHX;
}

MiningSimulatorState _expandCalculation(
    MiningSimulatorState state, Action action) {
  bool estate = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..mPowerExpand = estate;
}

MiningSimulatorState _expandDailyMining(
    MiningSimulatorState state, Action action) {
  bool estate = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..dailyMiningExpand = estate;
}

MiningSimulatorState _expandBond(MiningSimulatorState state, Action action) {
  bool estate = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..bondExpand = estate;
}
