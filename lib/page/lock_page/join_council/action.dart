import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

enum JoinCouncilAction {
  onConfirm,
  process,
  resSuccess,
  balance,
  councils,
  becomeCouncilChair,
}

class JoinCouncilActionCreator {
  static Action onConfirm(Council council) {
    return Action(JoinCouncilAction.onConfirm, payload: council);
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

  static Action councils(List<Council> councils) {
    return Action(JoinCouncilAction.councils, payload: councils);
  }

  static Action becomeCouncilChair() {
    return Action(JoinCouncilAction.becomeCouncilChair);
  }
}
