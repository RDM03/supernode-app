import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/device_component/action.dart';

import 'state.dart';

Reducer<DeviceState> buildReducer() {
  return asReducer(
    <Object, Reducer<DeviceState>>{
      DeviceAction.changeDeviceSortType: _changeDeviceSortType,
    },
  );
}

DeviceState _changeDeviceSortType(DeviceState state, Action action) {
  final DeviceState newState = state.clone();
  newState.deviceSortType = action.payload;
  return newState;
}