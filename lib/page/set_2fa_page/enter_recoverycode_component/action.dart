import 'package:fish_redux/fish_redux.dart';

enum EnterRecoveryCodeAction { onContinue }

class EnterRecoveryCodeActionCreator {
  static Action onContinue() {
    return const Action(EnterRecoveryCodeAction.onContinue);
  }
}