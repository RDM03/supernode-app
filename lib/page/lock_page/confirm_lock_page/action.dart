import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/dhx.dart';

enum ConfirmLockAction {
  onConfirm,
  process,
  resSuccess,
  balance,
  setCouncil,
}

class ConfirmLockActionCreator {
  static Action onConfirm() {
    return Action(ConfirmLockAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(ConfirmLockAction.resSuccess, payload: toogle);
  }

  static Action setCouncil(Council council) {
    return Action(ConfirmLockAction.setCouncil, payload: council);
  }
}
