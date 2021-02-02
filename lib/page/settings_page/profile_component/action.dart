import 'package:fish_redux/fish_redux.dart';

enum ProfileAction { onUpdate, jwtUpdate, showConfirmation, onUnbind, unbind, onShopifyEmail, onShopifyEmailVerification, bindShopifyStep}

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

  static Action onShopifyEmail(String email) {
    return Action(ProfileAction.onShopifyEmail, payload: email);
  }

  static Action onShopifyEmailVerification(String verificationCode) {
    return Action(ProfileAction.onShopifyEmailVerification, payload: verificationCode);
  }

  static Action bindShopifyStep(int step) {
    return Action(ProfileAction.bindShopifyStep, payload: step);
  }
}
