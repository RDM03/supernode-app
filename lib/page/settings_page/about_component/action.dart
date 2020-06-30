import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AboutAction { onCheckForUpdate }

class AboutActionCreator {
  static Action onCheckForUpdate() {
    return const Action(AboutAction.onCheckForUpdate);
  }
}
