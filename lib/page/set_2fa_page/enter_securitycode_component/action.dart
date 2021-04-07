import 'package:fish_redux/fish_redux.dart';

enum EnterSecurityCodeAction { onContinue }

class EnterSecurityCodeActionCreator {
  static Action onContinue() {
    return const Action(EnterSecurityCodeAction.onContinue);
  }
}
