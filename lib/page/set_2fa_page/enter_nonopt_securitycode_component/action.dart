import 'package:fish_redux/fish_redux.dart';

enum EnterNonOTPSecurityCodeAction { onContinue }

class EnterNonOTPSecurityCodeActionCreator {
  static Action onContinue() {
    return const Action(EnterNonOTPSecurityCodeAction.onContinue);
  }
}
