import 'package:fish_redux/fish_redux.dart';

enum GlobalAction { onSettings, changeThemeColor }

class GlobalActionCreator {
  static Action onSettings(data) {
    return Action(GlobalAction.onSettings,payload: data);
  }

  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }
}
