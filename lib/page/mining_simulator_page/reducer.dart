import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MiningSimulatorState> buildReducer() {
  return asReducer(
    <Object, Reducer<MiningSimulatorState>>{
      MiningSimulatorAction.mxcTotal: _mxcTotal,
      MiningSimulatorAction.minersTotal: _minersTotal,
      MiningSimulatorAction.months: _months,
      MiningSimulatorAction.lastMining: _lastMining,
      MiningSimulatorAction.expandCalculation: _expandCalculation,
    },
  );
}

MiningSimulatorState _mxcTotal(MiningSimulatorState state, Action action) {
  double val = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..mxcTotal = val;
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
  double totalDhx = action.payload[0];
  double yesterdayMining = action.payload[1];

  final MiningSimulatorState newState = state.clone();
  return newState
    ..dhxTotal = totalDhx
    ..yesterdayMining = yesterdayMining;
}

MiningSimulatorState _expandCalculation(
    MiningSimulatorState state, Action action) {
  CalculateExpandState estate = action.payload;

  final MiningSimulatorState newState = state.clone();
  return newState..calculateExpandState = estate;
}
