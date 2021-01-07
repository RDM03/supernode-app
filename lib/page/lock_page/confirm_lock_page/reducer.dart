import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

import 'action.dart';
import 'state.dart';

Reducer<ConfirmLockState> buildReducer() {
  return asReducer(
    <Object, Reducer<ConfirmLockState>>{
      ConfirmLockAction.resSuccess: _resSuccess,
      ConfirmLockAction.setCouncil: _setCouncil,
    },
  );
}

ConfirmLockState _resSuccess(ConfirmLockState state, Action action) {
  bool resSuccess = action.payload;

  final ConfirmLockState newState = state.clone();
  return newState..resSuccess = resSuccess;
}

ConfirmLockState _setCouncil(ConfirmLockState state, Action action) {
  Council council = action.payload;

  final ConfirmLockState newState = state.clone();
  return newState..council = council;
}
