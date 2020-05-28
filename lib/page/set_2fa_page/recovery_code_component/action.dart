import 'package:fish_redux/fish_redux.dart';

enum RecoveryCodeAction { onContinue, isAgreed }

class RecoveryCodeActionCreator {
  static Action onContinue() {
    return const Action(RecoveryCodeAction.onContinue);
  }

  static Action isAgreed(bool data) {
    return Action(RecoveryCodeAction.isAgreed,payload: data);
  }
}
