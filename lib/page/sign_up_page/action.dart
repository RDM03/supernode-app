import 'package:fish_redux/fish_redux.dart';

enum SignUpAction {
  onEmailContinue,
  onVerificationContinue,
  onRegistrationContinue,
  registrationContinue
}

class SignUpActionCreator {
  static Action onEmailContinue() {
    return const Action(SignUpAction.onEmailContinue);
  }

  static Action onVerificationContinue() {
    return const Action(SignUpAction.onVerificationContinue);
  }

  static Action onRegistrationContinue() {
    return const Action(SignUpAction.onRegistrationContinue);
  }

  static Action registrationContinue(Map data) {
    return Action(SignUpAction.registrationContinue, payload: data);
  }
}
