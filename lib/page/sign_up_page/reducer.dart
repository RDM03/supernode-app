import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SignUpState> buildReducer() {
  return asReducer(
    <Object, Reducer<SignUpState>>{
      SignUpAction.registrationContinue: _registrationContinue,
    },
  );
}

SignUpState _registrationContinue(SignUpState state, Action action) {
  Map data = action.payload;

  final SignUpState newState = state.clone();
  return newState
    ..emailCtl.text = data['email']
    ..userId = data['userId'];
}
