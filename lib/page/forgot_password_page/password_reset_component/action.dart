import 'package:fish_redux/fish_redux.dart';

enum PasswordResetAction { isObscureNewPWDText, isObscureConPWDText, onConfirm }

class PasswordResetActionCreator {

  static Action isObscureNewPWDText() {
    return const Action(PasswordResetAction.isObscureNewPWDText);
  }

  static Action isObscureConPWDText() {
    return const Action(PasswordResetAction.isObscureConPWDText);
  }
}
