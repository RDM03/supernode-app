import 'package:fish_redux/fish_redux.dart';

enum Get2FAAction { onContinue, onSubmit, onClose }

class Get2FAActionCreator {
  static Action onContinue() {
    return const Action(Get2FAAction.onContinue);
  }

  static Action onSubmit() {
    return const Action(Get2FAAction.onSubmit);
  }

  static Action onClose() {
    return const Action(Get2FAAction.onClose);
  }
}
