import 'package:fish_redux/fish_redux.dart';

enum LoginAction { selectedSuperNode, onLogin, onSignUp, onForgotPassword, isObscureText }

class LoginActionCreator {
  static Action selectedSuperNode(String node) {
    return Action(LoginAction.selectedSuperNode,payload: node);
  }

  static Action onLogin() {
    return const Action(LoginAction.onLogin);
  }

  static Action onSignUp() {
    return const Action(LoginAction.onSignUp);
  }

  static Action onForgotPasswordAction() {
    return const Action(LoginAction.onForgotPassword);
  }

  static Action isObscureText() {
    return const Action(LoginAction.isObscureText);
  }
}
