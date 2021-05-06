import 'package:fish_redux/fish_redux.dart';

enum PrepareLockAction {
  onConfirm,
  resSuccess,
  balance,
  minersOwned,
  lastMining,
}

class PrepareLockActionCreator {
  static Action onConfirm() {
    return Action(PrepareLockAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(PrepareLockAction.resSuccess, payload: toogle);
  }

  static Action balance(double balance) {
    return Action(PrepareLockAction.balance, payload: balance);
  }

  static Action minersOwned(int minersCount) {
    return Action(PrepareLockAction.minersOwned, payload: minersCount);
  }

  static Action lastMining(double totalDhx, double lastMining) {
    return Action(PrepareLockAction.lastMining,
        payload: [totalDhx, lastMining]);
  }
}
