import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum MapboxGlAction { action }

class MapboxGlActionCreator {
  static Action onAction() {
    return const Action(MapboxGlAction.action);
  }
}
