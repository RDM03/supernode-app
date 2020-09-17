import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<UnderMaintenanceState> buildReducer() {
  return asReducer(
    <Object, Reducer<UnderMaintenanceState>>{
      UnderMaintenanceAction.setLoading: _setLoading,
    },
  );
}

UnderMaintenanceState _setLoading(UnderMaintenanceState state, Action action) {
  bool val = action.payload;
  return UnderMaintenanceState(val);
}
