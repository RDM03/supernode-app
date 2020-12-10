import 'package:fish_redux/fish_redux.dart';

enum JoinCouncilAction { onConfirm, process, resSuccess, balance }

class JoinCouncilActionCreator {
  static Action onConfirm() {
    return Action(JoinCouncilAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(JoinCouncilAction.resSuccess, payload: toogle);
  }

  static Action process([String otpCode]) {
    return Action(JoinCouncilAction.process, payload: otpCode);
  }

  static Action balance(double balance) {
    return Action(JoinCouncilAction.balance, payload: balance);
  }
}
