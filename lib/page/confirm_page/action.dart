import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ConfirmAction { action }

class ConfirmActionCreator {
  static Action onAction() {
    return const Action(ConfirmAction.action);
  }
}
