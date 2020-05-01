import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<RegistrationState> buildReducer() {
  return asReducer(
    <Object, Reducer<RegistrationState>>{
      RegistrationAction.isCheckTerms: _isCheckTerms,
      RegistrationAction.isCheckSend: _isCheckSend,
      RegistrationAction.isObscureText: _isObscureText,
    },
  );
}

RegistrationState _isCheckTerms(RegistrationState state, Action action) {
  final RegistrationState newState = state.clone();
  return newState
    ..isCheckTerms = !state.isCheckTerms;
}

RegistrationState _isCheckSend(RegistrationState state, Action action) {
  final RegistrationState newState = state.clone();
  return newState
    ..isCheckSend = !state.isCheckSend;
}

RegistrationState _isObscureText(RegistrationState state, Action action) {
  final RegistrationState newState = state.clone();
  return newState
    ..isObscureText = !state.isObscureText;
}
