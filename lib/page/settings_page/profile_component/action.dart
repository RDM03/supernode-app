import 'package:fish_redux/fish_redux.dart';

enum ProfileAction { onUpdate, jwtUpdate, showConfirmation, onUnbind, unbind, onBindShopify }

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

  static Action onUnbind(String service) {
    return Action(ProfileAction.onUnbind, payload: service);
  }

  static Action unbind(String service) {
    return Action(ProfileAction.unbind, payload: service);
  }

  static Action onBindShopify() {
    return Action(ProfileAction.onBindShopify);
  }
}
