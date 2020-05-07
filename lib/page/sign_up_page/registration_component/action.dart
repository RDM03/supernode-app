import 'package:fish_redux/fish_redux.dart';

enum RegistrationAction { isCheckTerms, isCheckSend, isObscureText }

class RegistrationActionCreator {
  static Action isCheckTerms() {
    return const Action(RegistrationAction.isCheckTerms);
  }

  static Action isCheckSend() {
    return const Action(RegistrationAction.isCheckSend);
  }

  static Action isObscureText() {
    return const Action(RegistrationAction.isObscureText);
  }
}
