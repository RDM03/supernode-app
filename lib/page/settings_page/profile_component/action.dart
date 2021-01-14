import 'package:fish_redux/fish_redux.dart';

enum ProfileAction { onUpdate, jwtUpdate, showConfirmation, onUnbind, unbind }

class ProfileActionCreator {
  static Action onUpdate() {
    return const Action(ProfileAction.onUpdate);
  }

  static Action jwtUpdate(Map data) {
    return Action(ProfileAction.jwtUpdate,payload: data);
  }

  static Action showConfirmation(bool data) {
    return Action(ProfileAction.showConfirmation, payload: data);
  }

  static Action onUnbind() {
    return const Action(ProfileAction.onUnbind);
  }

  static Action unbind() {
    return Action(ProfileAction.unbind);
  }
}
