import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/forgot_password_page/action.dart';

import 'state.dart';

Reducer<ForgotPasswordState> buildReducer() {
  return asReducer(
    <Object, Reducer<ForgotPasswordState>>{
      ForgotPasswordAction.setEmail: _setEmail,
    },
  );
}

ForgotPasswordState _setEmail(ForgotPasswordState state, Action action) {
  final ForgotPasswordState newState = state.clone();
  return newState..email = action.payload;
}
