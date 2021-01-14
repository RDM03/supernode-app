import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/repositories/supernode/dao/stake.dart';

enum ListUnstakeAction {
  setStakes,
}

class ListUnstakeActionCreator {
  static Action setStakes(List<Stake> stakes) {
    return Action(ListUnstakeAction.setStakes, payload: stakes);
  }
}
