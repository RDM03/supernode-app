import 'package:fish_redux/fish_redux.dart';

enum Set2FAAction { initState, isEnabled, onConfirm }

class Set2FAActionCreator {

  static Action onConfirm() {
    return const Action(Set2FAAction.onConfirm);
  }

  static Action isEnabled(bool data) {
    return Action(Set2FAAction.isEnabled,payload: data);
  }

}