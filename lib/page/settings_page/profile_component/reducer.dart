import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProfileState>>{
      ProfileAction.jwtUpdate: _jwtUpdate,
      ProfileAction.showConfirmation: _showConfirmation,
      ProfileAction.unbind: _unbind,
    },
  );
}

ProfileState _jwtUpdate(ProfileState state, Action action) {
  Map data = action.payload;

  final ProfileState newState = state.clone();
  return newState
    ..reloadProfile = true
    ..username = data['username']
    ..email = data['email'];
}

ProfileState _showConfirmation(ProfileState state, Action action) {
  bool data = action.payload;

  final ProfileState newState = state.clone();
  return newState
    ..showConfirmation = data;
}

ProfileState _unbind(ProfileState state, Action action) {
  final ProfileState newState = state.clone();
  return newState
    ..reloadProfile = true
    ..wechatExternalUsername = '';
}
