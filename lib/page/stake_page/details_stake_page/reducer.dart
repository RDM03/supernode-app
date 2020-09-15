import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<DetailsStakeState> buildReducer() {
  return asReducer(
    <Object, Reducer<DetailsStakeState>>{
      DetailsStakeAction.setOtpEnabled: _setOtpEnabled,
    },
  );
}

DetailsStakeState _setOtpEnabled(DetailsStakeState state, Action action) {
  final DetailsStakeState newState = state.clone();

  return newState..otpEnabled = action.payload;
}
