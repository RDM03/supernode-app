import 'package:fish_redux/fish_redux.dart';
import 'package:supernodeapp/page/home_page/user_component/state.dart';

import 'action.dart';

Reducer<UserState> buildReducer() {
  return asReducer(
    <Object, Reducer<UserState>>{
      LoginAction.selectedSuperNode: _selectedSuperNode,
      LoginAction.isObscureText: _isObscureText,
    },
  );
}

UserState _selectedSuperNode(UserState state, Action action) {
  String selectedNode = action.payload;

  final UserState newState = state.clone();
  return newState
    ..selectedSuperNode = selectedNode;
}

UserState _isObscureText(UserState state, Action action) {

  final UserState newState = state.clone();
  return newState
    ..isObscureText = !state.isObscureText;
}