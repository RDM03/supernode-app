import 'package:fish_redux/fish_redux.dart';

enum VerificationCodeAction { onContinue }

class VerificationCodeActionCreator {
  static Action onContinue() {
    return const Action(VerificationCodeAction.onContinue);
  }
}
