import 'package:fish_redux/fish_redux.dart';

enum ChangePasswordAction {
  isObscureOldPWDText,
  isObscureNewPWDText,
  isObscureConPWDText,
  onConfirm
}

class ChangePasswordActionCreator {
  static Action onConfirm() {
    return const Action(ChangePasswordAction.onConfirm);
  }

  static Action isObscureOldPWDText() {
    return const Action(ChangePasswordAction.isObscureOldPWDText);
  }

  static Action isObscureNewPWDText() {
    return const Action(ChangePasswordAction.isObscureNewPWDText);
  }

  static Action isObscureConPWDText() {
    return const Action(ChangePasswordAction.isObscureConPWDText);
  }
}
