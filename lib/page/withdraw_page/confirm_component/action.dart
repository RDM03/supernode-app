import 'package:fish_redux/fish_redux.dart';

enum EnterSecurityCodeWithdrawAction { onContinue }

class EnterSecurityCodeWithdrawActionCreator {
  static Action onContinue() {
    return const Action(EnterSecurityCodeWithdrawAction.onContinue);
  }
}