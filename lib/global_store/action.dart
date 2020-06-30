import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/data/super_node_bean.dart';

enum GlobalAction { onSettings, changeThemeColor, choiceSuperNode }

class GlobalActionCreator {
  static Action onSettings(data) {
    return Action(GlobalAction.onSettings, payload: data);
  }

  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action choiceSuperNode(SuperNodeBean node) {
    return Action(GlobalAction.choiceSuperNode, payload: node);
  }
}
