import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<MiningSimulatorState> buildReducer() {
  return asReducer(
    <Object, Reducer<MiningSimulatorState>>{
      MiningSimulatorAction.mxcTotal: _mxcTotal,
      MiningSimulatorAction.minersTotal: _minersTotal,
      MiningSimulatorAction.months: _months,
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
