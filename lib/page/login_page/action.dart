import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/data/super_node_bean.dart';

enum LoginAction {
  isObscureText,
  selectedSuperNode,
  superNodeListVisible,
  onLogin,
  onSignUp,
  onForgotPassword,
}

class LoginActionCreator {
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

  static Action selectedSuperNode(SuperNodeBean node) {
    return Action(LoginAction.selectedSuperNode, payload: node);
  }

  static Action superNodeListVisible(bool state) {
    return Action(LoginAction.superNodeListVisible, payload: state);
  }
}
