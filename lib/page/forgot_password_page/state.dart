import 'package:fish_redux/fish_redux.dart';

class ForgotPasswordState implements Cloneable<ForgotPasswordState> {

  @override
  ForgotPasswordState clone() {
    return ForgotPasswordState();
  }
}

ForgotPasswordState initState(Map<String, dynamic> args) {
  return ForgotPasswordState();
}
