import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/components/stake/stake_item.dart';

enum ListUnstakeAction {
  setStakes,
}

class ListUnstakeActionCreator {
  static Action setStakes(List<Stake> stakes) {
    return Action(ListUnstakeAction.setStakes, payload: stakes);
  }
}
