import 'package:fish_redux/fish_redux.dart';
import 'state.dart';
import 'action.dart';

Reducer<LoginState> buildReducer() {
  return asReducer(
    <Object, Reducer<LoginState>>{
      LoginAction.selectedSuperNode: _selectedSuperNode,
      LoginAction.isObscureText: _isObscureText,
      LoginAction.superNodeListVisible: _superNodeListVisible,
    },
  );
}

LoginState _selectedSuperNode(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState
    ..currentSuperNode = action.payload
    ..showSuperNodeList = false;
}

LoginState _isObscureText(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState..isObscureText = !state.isObscureText;
}

LoginState _superNodeListVisible(LoginState state, Action action) {
  final LoginState newState = state.clone();
  return newState..showSuperNodeList = action.payload;
}
