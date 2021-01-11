import 'package:fish_redux/fish_redux.dart';

enum PrepareStakeAction { onConfirm, process, resSuccess, balance }

class PrepareStakeActionCreator {
  static Action onConfirm() {
    return Action(PrepareStakeAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(PrepareStakeAction.resSuccess, payload: toogle);
  }

  static Action process([String otpCode]) {
    return Action(PrepareStakeAction.process, payload: otpCode);
  }

  static Action balance(double balance) {
    return Action(PrepareStakeAction.balance, payload: balance);
  }
}
