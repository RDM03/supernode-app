import 'package:fish_redux/fish_redux.dart';

enum DetailsStakeAction {
  unstake,
  unstakeProcess,
  refreshOtpStatus,
  setOtpEnabled,
}

class DetailsStakeActionCreator {
  static Action unstake() {
    return Action(DetailsStakeAction.unstake);
  }

  static Action refreshOtpStatus() {
    return Action(DetailsStakeAction.refreshOtpStatus);
  }

  static Action setOtpEnabled(bool val) {
    return Action(DetailsStakeAction.setOtpEnabled, payload: val);
  }

  static Action unstakeProcess([String otpCode]) {
    return Action(DetailsStakeAction.unstakeProcess, payload: otpCode);
  }
}
