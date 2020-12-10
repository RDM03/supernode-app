import 'package:fish_redux/fish_redux.dart';

enum PrepareLockAction { onConfirm, process, resSuccess, balance }

class PrepareLockActionCreator {
  static Action onConfirm() {
    return Action(PrepareLockAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(PrepareLockAction.resSuccess, payload: toogle);
  }

  static Action process([String otpCode]) {
    return Action(PrepareLockAction.process, payload: otpCode);
  }

  static Action balance(double balance) {
    return Action(PrepareLockAction.balance, payload: balance);
  }
}
