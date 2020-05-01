import 'package:fish_redux/fish_redux.dart';

enum SecurityAction { onChangePassword }

class SecurityActionCreator {
  static Action onChangePassword() {
    return const Action(SecurityAction.onChangePassword);
  }
}
