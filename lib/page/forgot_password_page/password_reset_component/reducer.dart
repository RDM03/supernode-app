import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/forgot_password_page/password_reset_component/action.dart';

import 'state.dart';

Reducer<PasswordResetState> buildReducer() {
  return asReducer(
    <Object, Reducer<PasswordResetState>>{
      PasswordResetAction.isObscureNewPWDText: _isObscureNewPWDText,
      PasswordResetAction.isObscureConPWDText: _isObscureConPWDText,
    },
  );
}

PasswordResetState _isObscureNewPWDText(
    PasswordResetState state, Action action) {
  final PasswordResetState newState = state.clone();
  return newState..isObscureNewPWDText = !state.isObscureNewPWDText;
}

PasswordResetState _isObscureConPWDText(
    PasswordResetState state, Action action) {
  final PasswordResetState newState = state.clone();
  return newState..isObscureConPWDText = !state.isObscureConPWDText;
}
