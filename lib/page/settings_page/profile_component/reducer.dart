import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ProfileState> buildReducer() {
  return asReducer(
    <Object, Reducer<ProfileState>>{
      ProfileAction.update: _update,
      ProfileAction.unbind: _unbind,
    },
  );
}

ProfileState _update(ProfileState state, Action action) {
  Map data = action.payload;

  final ProfileState newState = state.clone();
  return newState
    ..username = data['username']
    ..email = data['email'];
}

ProfileState _unbind(ProfileState state, Action action) {
  final ProfileState newState = state.clone();
  return newState
    ..wechatExternalUsername = '';
}
