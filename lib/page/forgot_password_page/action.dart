import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ForgotPasswordAction { action }

class ForgotPasswordActionCreator {
  static Action onAction() {
    return const Action(ForgotPasswordAction.action);
  }
}
