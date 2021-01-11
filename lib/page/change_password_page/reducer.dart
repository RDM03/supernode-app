import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChangePasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChangePasswordState>>{
      ChangePasswordAction.isObscureOldPWDText: _isObscureOldPWDText,
      ChangePasswordAction.isObscureNewPWDText: _isObscureNewPWDText,
      ChangePasswordAction.isObscureConPWDText: _isObscureConPWDText,
    },
  );
}

ChangePasswordState _isObscureOldPWDText(
    ChangePasswordState state, Action action) {
  final ChangePasswordState newState = state.clone();
  return newState..isObscureOldPWDText = !state.isObscureOldPWDText;
}

ChangePasswordState _isObscureNewPWDText(
    ChangePasswordState state, Action action) {
  final ChangePasswordState newState = state.clone();
  return newState..isObscureNewPWDText = !state.isObscureNewPWDText;
}

ChangePasswordState _isObscureConPWDText(
    ChangePasswordState state, Action action) {
  final ChangePasswordState newState = state.clone();
  return newState..isObscureConPWDText = !state.isObscureConPWDText;
}
