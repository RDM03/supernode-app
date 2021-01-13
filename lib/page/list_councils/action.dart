import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/common/daos/dhx_dao.dart';

enum ListCouncilsAction {
  councils,
  tab,
}

class ListCouncilsActionCreator {
  static Action councils(List<Council> councils, List<Council> joined) {
    return Action(ListCouncilsAction.councils, payload: [councils, joined]);
  }

  static Action tab(int tab) {
    return Action(ListCouncilsAction.tab, payload: tab);
  }
}
