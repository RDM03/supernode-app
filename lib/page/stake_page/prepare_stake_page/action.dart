import 'package:fish_redux/fish_redux.dart';

enum PrepareStakeAction {
  onConfirm,
  process,
  resSuccess,
}

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
}
