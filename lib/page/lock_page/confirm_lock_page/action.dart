import 'package:fish_redux/fish_redux.dart';

enum ConfirmLockAction { onConfirm, process, resSuccess, balance }

class ConfirmLockActionCreator {
  static Action onConfirm() {
    return Action(ConfirmLockAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(ConfirmLockAction.resSuccess, payload: toogle);
  }
}
