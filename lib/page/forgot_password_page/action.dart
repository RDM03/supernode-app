import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ForgotPasswordAction {
  onEmailContinue,
  onVerificationContinue,
  setEmail,
  onHasCode,
}

class ForgotPasswordActionCreator {
  static Action onEmailContinue() {
    return const Action(ForgotPasswordAction.onEmailContinue);
  }

  static Action onVerificationContinue() {
    return const Action(ForgotPasswordAction.onVerificationContinue);
  }

  static Action setEmail(String email) {
    return Action(ForgotPasswordAction.setEmail, payload: email);
  }

  static Action onHasCode() {
    return Action(ForgotPasswordAction.onHasCode);
  }
}
