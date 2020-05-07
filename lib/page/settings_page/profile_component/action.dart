import 'package:fish_redux/fish_redux.dart';

enum ProfileAction { onUpdate, update }

class ProfileActionCreator {
  static Action onUpdate() {
    return const Action(ProfileAction.onUpdate);
  }

  static Action update(Map data) {
    return Action(ProfileAction.update,payload: data);
  }
}
