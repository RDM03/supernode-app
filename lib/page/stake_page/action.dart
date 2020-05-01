import 'package:fish_redux/fish_redux.dart';

enum StakeAction { onConfirm, resSuccess }

class StakeActionCreator {
  static Action onConfirm() {
    return const Action(StakeAction.onConfirm);
  }

  static Action resSuccess(bool toogle) {
    return Action(StakeAction.resSuccess,payload: toogle);
  }
}
