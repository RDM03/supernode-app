import 'package:fish_redux/fish_redux.dart';

enum StakeAction { onConfirm, process, resSuccess, setOtpEnabled, refreshOtpStatus }

class StakeActionCreator {
  static Action onConfirm() {
    return Action(StakeAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(StakeAction.resSuccess, payload: toogle);
  }

  static Action setOtpEnabled(bool value) {
    return Action(StakeAction.setOtpEnabled, payload: value);
  }

  static Action process([String otpCode]) {
    return Action(StakeAction.process, payload: otpCode);
  }

  static Action refreshOtpStatus() {
    return Action(StakeAction.refreshOtpStatus);
  }
}
