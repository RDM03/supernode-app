import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum mapboxAction { action }

class mapboxActionCreator {
  static Action onAction() {
    return const Action(mapboxAction.action);
  }
}
